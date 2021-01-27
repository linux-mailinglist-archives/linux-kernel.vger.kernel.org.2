Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A39306341
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhA0S0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:26:23 -0500
Received: from mx.exactcode.de ([144.76.154.42]:55778 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235521AbhA0S0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:26:08 -0500
X-Greylist: delayed 1015 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 13:26:08 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To:Message-Id:Date; bh=1B33gqolHp2zCPWtvUn7Q4HzJ8uPUWWP0F8LP347TdM=;
        b=D9Gv0UI2PfDQBcDkNsAnP3qRGstfykDWeHXdvfSSK0134HmInowd3tzYlx54xRjqTwY7vhylAN1xogynPQDVMDW4G2qxULgXOiamfj6UiLduSa4iy/X1wwiTjb73sAn93h+8eVR6rqWR73tdsByf61weSwQM3feP6mVfvPBupQI=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1l4pFY-0002D7-Bg; Wed, 27 Jan 2021 18:09:04 +0000
Received: from [192.168.2.130] (helo=localhost)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1l4p6m-0005Lz-Fo; Wed, 27 Jan 2021 18:00:01 +0000
Date:   Wed, 27 Jan 2021 19:08:23 +0100 (CET)
Message-Id: <20210127.190823.1013816968702108983.rene@exactcode.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] add missing MPSC to X86_INTEL_USERCOPY and
 _USE_PPRO_CHECKSUM
From:   Rene Rebe <rene@exactcode.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -3.1 (---)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging some bizare memory corruption in certain kernel configs on
some machines, I noticed MPSC (1st gen Intel X64 Nocona) is missing in
selecting X86_INTEL_USERCOPY and X86_USE_PPRO_CHECKSUM. Unless someone
has a good reason not to, I think MPSC should select the two, and
maybe MATOM should also made select X86_INTEL_USERCOPY?

Signed-of-by: Ren=E9 Rebe <rene@exactcode.de>

--- linux-5.10/arch/x86/Kconfig.cpu.vanilla	2021-01-27 16:09:20.1639300=
78 +0100
+++ linux-5.10/arch/x86/Kconfig.cpu	2021-01-27 16:36:35.064014421 +0100=

@@ -336,11 +336,11 @@
 =

 config X86_INTEL_USERCOPY
 	def_bool y
-	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M58=
6MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2
+	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M58=
6MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2 || MPSC
 =

 config X86_USE_PPRO_CHECKSUM
 	def_bool y
-	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPE=
NTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIA=
C3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM
+	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPE=
NTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIA=
C3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM || MPSC
 =

 config X86_USE_3DNOW
 	def_bool y


-- =

  Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactcode.com | https://t2sde.org | https://rene.rebe.de
