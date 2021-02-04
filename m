Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7EB30CEAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBBWTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:19:50 -0500
Received: from foss.arm.com ([217.140.110.172]:58526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234883AbhBBWST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:18:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 703A41516;
        Tue,  2 Feb 2021 14:17:02 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1633F694;
        Tue,  2 Feb 2021 14:17:00 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v6 13/37] cpufreq: scmi: port driver to the new scmi_perf_proto_ops interface
Date:   Tue,  2 Feb 2021 22:15:31 +0000
Message-Id: <20210202221555.41167-14-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202221555.41167-1-cristian.marussi@arm.com>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port driver to the new SCMI Perf interface based on protocol handles
and common devm_get_ops().

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- using renamed devm_get/put_protocol
---
 drivers/cpufreq/scmi-cpufreq.c | 37 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 491a0a24fb1e..e4c2ee3ea754 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -25,17 +25,17 @@ struct scmi_data {
 	struct device *cpu_dev;
 };
 
-static const struct scmi_handle *handle;
+static struct scmi_protocol_handle *ph;
+static const struct scmi_perf_proto_ops *perf_ops;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 	struct scmi_data *priv = policy->driver_data;
 	unsigned long rate;
 	int ret;
 
-	ret = perf_ops->freq_get(handle, priv->domain_id, &rate, false);
+	ret = perf_ops->freq_get(ph, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
 	return rate / 1000;
@@ -50,19 +50,17 @@ static int
 scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct scmi_data *priv = policy->driver_data;
-	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 	u64 freq = policy->freq_table[index].frequency;
 
-	return perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
+	return perf_ops->freq_set(ph, priv->domain_id, freq * 1000, false);
 }
 
 static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
-	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 
-	if (!perf_ops->freq_set(handle, priv->domain_id,
+	if (!perf_ops->freq_set(ph, priv->domain_id,
 				target_freq * 1000, true))
 		return target_freq;
 
@@ -75,7 +73,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	int cpu, domain, tdomain;
 	struct device *tcpu_dev;
 
-	domain = handle->perf_ops->device_domain_id(cpu_dev);
+	domain = perf_ops->device_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -87,7 +85,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		if (!tcpu_dev)
 			continue;
 
-		tdomain = handle->perf_ops->device_domain_id(tcpu_dev);
+		tdomain = perf_ops->device_domain_id(tcpu_dev);
 		if (tdomain == domain)
 			cpumask_set_cpu(cpu, cpumask);
 	}
@@ -102,13 +100,13 @@ scmi_get_cpu_power(unsigned long *power, unsigned long *KHz,
 	unsigned long Hz;
 	int ret, domain;
 
-	domain = handle->perf_ops->device_domain_id(cpu_dev);
+	domain = perf_ops->device_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
 	/* Get the power cost of the performance domain. */
 	Hz = *KHz * 1000;
-	ret = handle->perf_ops->est_power_get(handle, domain, &Hz, power);
+	ret = perf_ops->est_power_get(ph, domain, &Hz, power);
 	if (ret)
 		return ret;
 
@@ -134,7 +132,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
+	ret = perf_ops->device_opps_add(ph, cpu_dev);
 	if (ret) {
 		dev_warn(cpu_dev, "failed to add opps to the device\n");
 		return ret;
@@ -173,7 +171,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = handle->perf_ops->device_domain_id(cpu_dev);
+	priv->domain_id = perf_ops->device_domain_id(cpu_dev);
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
@@ -181,16 +179,16 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
-	latency = handle->perf_ops->transition_latency_get(handle, cpu_dev);
+	latency = perf_ops->transition_latency_get(ph, cpu_dev);
 	if (!latency)
 		latency = CPUFREQ_ETERNAL;
 
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible =
-		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
+		perf_ops->fast_switch_possible(ph, cpu_dev);
 
-	power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
+	power_scale_mw = perf_ops->power_scale_mw_get(ph);
 	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
 				    power_scale_mw);
 
@@ -233,12 +231,17 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
 	struct device *dev = &sdev->dev;
+	const struct scmi_handle *handle;
 
 	handle = sdev->handle;
 
-	if (!handle || !handle->perf_ops)
+	if (!handle)
 		return -ENODEV;
 
+	perf_ops = handle->devm_get_protocol(sdev, SCMI_PROTOCOL_PERF, &ph);
+	if (IS_ERR(perf_ops))
+		return PTR_ERR(perf_ops);
+
 #ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */
 	if (of_find_property(dev->of_node, "#clock-cells", NULL))
-- 
2.17.1

