Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78FA40B0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhINOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233872AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5D4661166;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=NvR0aGI4jVMzGyFJm0RPZ2nXSN3IomPG5411ayW0HtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqmG+at+f9j/4FfDHZiGZyMIzV2/te6MXiKCXRJMEnbfXDqwHDEVx2ECqLZHJEmCN
         SNh8jTti72TFS76+Iiv/KRPXdwiKcDuvdF0GnYDSm+t0ZoeT/mf8/3c2E0lb1K2eR0
         +DUB53lqTk1+SsMMV2IVxDnRXNqUMrkRMgswjwWRzZ2disamI71OA0wDX4CMoNAquc
         NAfgBU3qyyZYmMVTjMMvOgqLb3H64VQYkbKWlZ4H66CIPTUUJRli+Bpqg+jLuvesvu
         lLGRx8oVN/vS9qNsQQbcXmyp3u6sXoheA3r7hMzxC2k/0clQ079+DSpWvX0uH5Je6S
         FjcRwEP3XzzRA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000KlU-8M; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/29] ABI: sysfs-class-pwm: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:35 +0200
Message-Id: <1838d8fb149170f6c19feda0645d6c3157f46f4f.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like.
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-pwm | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-pwm b/Documentation/ABI/testing/sysfs-class-pwm
index c20e61354561..3d65285bcd5f 100644
--- a/Documentation/ABI/testing/sysfs-class-pwm
+++ b/Documentation/ABI/testing/sysfs-class-pwm
@@ -7,7 +7,7 @@ Description:
 		Framework and provides a sysfs interface for using PWM
 		channels.
 
-What:		/sys/class/pwm/pwmchipN/
+What:		/sys/class/pwm/pwmchip<N>/
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -16,14 +16,14 @@ Description:
 		probed PWM controller/chip where N is the base of the
 		PWM chip.
 
-What:		/sys/class/pwm/pwmchipN/npwm
+What:		/sys/class/pwm/pwmchip<N>/npwm
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
 Description:
 		The number of PWM channels supported by the PWM chip.
 
-What:		/sys/class/pwm/pwmchipN/export
+What:		/sys/class/pwm/pwmchip<N>/export
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -31,14 +31,14 @@ Description:
 		Exports a PWM channel from the PWM chip for sysfs control.
 		Value is between 0 and /sys/class/pwm/pwmchipN/npwm - 1.
 
-What:		/sys/class/pwm/pwmchipN/unexport
+What:		/sys/class/pwm/pwmchip<N>/unexport
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
 Description:
 		Unexports a PWM channel.
 
-What:		/sys/class/pwm/pwmchipN/pwmX
+What:		/sys/class/pwm/pwmchip<N>/pwmX
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -47,21 +47,21 @@ Description:
 		each exported PWM channel where X is the exported PWM
 		channel number.
 
-What:		/sys/class/pwm/pwmchipN/pwmX/period
+What:		/sys/class/pwm/pwmchip<N>/pwmX/period
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
 Description:
 		Sets the PWM signal period in nanoseconds.
 
-What:		/sys/class/pwm/pwmchipN/pwmX/duty_cycle
+What:		/sys/class/pwm/pwmchip<N>/pwmX/duty_cycle
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
 Description:
 		Sets the PWM signal duty cycle in nanoseconds.
 
-What:		/sys/class/pwm/pwmchipN/pwmX/polarity
+What:		/sys/class/pwm/pwmchip<N>/pwmX/polarity
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -69,7 +69,7 @@ Description:
 		Sets the output polarity of the PWM signal to "normal" or
 		"inversed".
 
-What:		/sys/class/pwm/pwmchipN/pwmX/enable
+What:		/sys/class/pwm/pwmchip<N>/pwmX/enable
 Date:		May 2013
 KernelVersion:	3.11
 Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -78,7 +78,7 @@ Description:
 		0 is disabled
 		1 is enabled
 
-What:		/sys/class/pwm/pwmchipN/pwmX/capture
+What:		/sys/class/pwm/pwmchip<N>/pwmX/capture
 Date:		June 2016
 KernelVersion:	4.8
 Contact:	Lee Jones <lee.jones@linaro.org>
-- 
2.31.1

