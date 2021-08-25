Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730913F6EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhHYFSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHYFSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:18:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF5C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:17:20 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id u21so15911388qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=sQUEtqzoa+EFTywOIBGHuHM7bFINlOGtj4j6rHvTz+0=;
        b=CV/1sVWlQpkEZx7/21dzgIpkQhY+u5Kt4gLkFGGapn7JHo5XZ7dR3w6+H1cLM6zDx1
         gTkk5XVJnSSQKQPHH45T7FBPkUJzChS718ZB6ykrucqk3+dNrNtV9sPYIX/UZbgI2K2L
         z0VAuJmuDWhdGTaBDSRQO436/69YJHjQcMD8mYZ/7aXJ7Z6U57HIiFhZ/MWEZBgGNHZM
         C5B5hCz7/kQLiIg5466DMkNOM1XOhKjTN5Bvjeuc7a5tdD4eT7MxxhB6GQD8nwRqv7I3
         LTRCRv4JADOfC3lT1sBkraj8w9q6zIXqyNz8EbroLQ5T4sZ20uQ93MWCNu9ACW1fo7oL
         KBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=sQUEtqzoa+EFTywOIBGHuHM7bFINlOGtj4j6rHvTz+0=;
        b=cpzLsbqnERbt8EfaWbHOo97x0zFmrc8kd5xJBHY58AEV6zJYvI3u5hU+u/hd0Fop+2
         NnHtnAtdfWOjAdorJ5jSl11LBG4yP8jjixI3jo/XQlpUloqyjA3/ME3cYjD3Pj1qmFv9
         u5PLuKX5rsnjQAzJS15ACnO6C/PkJ+KJfBGofvey4NqymLpZuy8UDd+u8Mh3mkkrhyub
         KgPikmao1Js2G/+MZPDb/ujSM8NDO32G9dE1jX0EKaL3PAWMS1ibdtmCMqHHYv9dRaGf
         wFuyYrslCJfrv0pn/AojrXhpzimkrjSuc+IIsNa406sOrMuT02CwYhC3pEnu4LikR3CM
         8UPA==
X-Gm-Message-State: AOAM530uWU4f5+i5BddWnf/5athlQ5USPH2yMnUhMiWaYfzBDt1nUHUl
        I2D6dkMjuoLcDOCm8hAEbzJPRA==
X-Google-Smtp-Source: ABdhPJxCUtRu+HnI26oPORvphSR7QJ/zGe8c0zQuZDaUuOIHEBzofeIUVatyW7y+mFu2yIcI+ZrwfA==
X-Received: by 2002:ac8:4b6c:: with SMTP id g12mr27903542qts.170.1629868639785;
        Tue, 24 Aug 2021 22:17:19 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id u7sm8460198qtc.75.2021.08.24.22.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 22:17:19 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Sudeep Holla <sudeep.holla@arm.com>,
        SeongJae Park <sj38.park@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: Fix 'make allmodconfig' build, part 2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 25 Aug 2021 01:17:18 -0400
Message-ID: <14920.1629868638@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 86afc1df661a adds a reference to a symbol that doesn't have an
EXPORT_PER_CPU_SYMBOL, which fails if qcom-cpufreq-hw is built as a module.

ERROR: modpost: "cpu_scale" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!

Thanks to Seonjae Park for pointing me in the right direction.

Fixes: 86afc1df661a ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Suggested-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 921312a8d957..7e7de763bd88 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -149,6 +149,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 }
 
 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 {

