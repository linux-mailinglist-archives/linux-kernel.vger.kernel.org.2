Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160473E5C53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbhHJNzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:55:05 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60795 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242060AbhHJNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:55:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628603682; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=k4nrFBYjkENYXFRZoyAl9snMXCad6DKybTDWMgXjTBE=; b=AJdgbISDLK52KgODdJs7/SO97K2MySktw+b3f58PmObb1BuxFFFp4ZesWLocfoMcw9hq+ItM
 BVSbo7WAcEXvpAGw+B9BvlSHsob7cFwQhQNsjfRqA6fn+9embfNew/jsVVXIAaJR4/ZN+5aR
 rp2Dirrl/CaJR4LCgLfsxfv2IT4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 611285137ee6040977480b55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 13:54:27
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8998C4323A; Tue, 10 Aug 2021 13:54:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DE98C4323A;
        Tue, 10 Aug 2021 13:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DE98C4323A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net
Cc:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, psodagud@codeaurora.org
Subject: [PATCH v2] PM: sleep: core: Avoid setting power.must_resume to false
Date:   Tue, 10 Aug 2021 06:54:17 -0700
Message-Id: <1628603658-261568-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is regarding suspend/resume(s2idle) scenario of devices and difference
between the LTS kernels 5.4 and 5.10 with respect to devices suspend and
resume. Observing that devices suspended in suspend_late stage are not
getting resumed in resume_early stage.
1) LTS kernel 5.4 kernel do not have this problem but 5.10 kernel
shows this problem.
2) 'commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")'
is skipping the driver early_resume callbacks.

In device_resume_early function dev->power.must_resume is used to skip the
resume call back. It looks this function is expecting that,
__device_suspend_noirq() would set dev->power.must_resume = true for the
devices which does not have DPM_FLAG_MAY_SKIP_RESUME flag set.

3) Problematic scenario is as follows -  During the device suspend/resume
scenario all the devices in  the suspend_late stage are successful and some
device can fail to suspend in suspend_noirq(device_suspend_noirq->
__device_suspend_noirq) phase.
As a device failed in dpm_noirq_suspend_devices phase, dpm_resume_noirq is
getting called to resume devices in dpm_late_early_list in the noirq phase.

4) During the Devices_early_resume stage
dpm_resume_early()-->device_resume_early() functions skipping the devices
early resume callbacks.
799         if (dev_pm_skip_resume(dev))
800                  goto Skip;

5) Devices suspended in suspend_late stage are not getting resumed in
Devices_early_resume stage because of
'commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")'
is skipping the driver early_resume callbacks when dev->power.must_resume is false.


Changelog:
v1 -> v2:
 - Fixed indentation comments.
 - Commit text updated to include scenario.

Prasad Sodagudi (1):
  PM: sleep: core: Avoid setting power.must_resume to false

 drivers/base/power/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

