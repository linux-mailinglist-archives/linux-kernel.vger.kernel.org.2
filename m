Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCB432003B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhBSVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:18:08 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54147 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhBSVR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:17:58 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CDC175C00E1;
        Fri, 19 Feb 2021 16:16:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Feb 2021 16:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=8JX0di8RBdkip
        b+xevye7JObwYOqMI/S94JegcGbQPc=; b=u5WvDiKJsC/17fqA6KkTPIk0rp/lW
        DxkIZOHV7nktxt3FSXDrLZLAtxeACgeJRtS3uM6e3k1gJcEMzcqWWMwRqdF3/XTR
        1iN3zvF0eopfJK1bsDvrulFFr5TsD8ohWV/sAqHisBPkzrCAtxYx8RJlIRWwKexx
        ZCPWWaxU41m9P5StX65w0fz4g/JPDLWtvTElBnPbnoPum2xjVP7728gb8DBnYUIf
        0kKl4YC2QJuZ/JPCANc6I62uGOCx0epY0AHOMgiNma3KYcsiTySQzX6lAIKwUEZH
        ORYc3bTfdcyep+KutB3Oz7E/QAnl/hEQTZJ486/croNZr/yc5aPnqL3aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=8JX0di8RBdkipb+xevye7JObwYOqMI/S94JegcGbQPc=; b=m5Jt56ZE
        h7IiEyu0tVihuB7kPctLAieity3O+R+US7HiFLBq2exkU7Pf2eZcnKbO1f60nPk3
        jHJ8Vk3rA4cDCvyKKoS4REd6xnc47k0ClBQ5kEJcLhRYL+1CHDvuf5knp9TVs4gL
        a4kAqb1oVtkopFNQs8Psjy2nj1EEAm4ZzTr1A4WWkhl0tDYgwb+oAuleaoultu2O
        DEVKpsjHKYu28PngKwUk98uNvZOdrMMS+XWDViLGVepp+TtZr+1JEqf7z7nx3ioK
        FZNYs9T/RAP7U5RlXHfXjSbERrMQ0rUTkNyUGHd9yqPs9AubEuWH01iLSPIYZINq
        QKfxLdaotvLfsA==
X-ME-Sender: <xms:xCowYIKVyOfxw_Jyv8FtZZMYNF0nmV7cx_3xMAkz_lKEMpmJGedp4w>
    <xme:xCowYIKQiL5hPHaNUrYmxu77Jr3C3PyFnPUEgYQHaaXkt9cSm7Wk2ALXXcGv8moKl
    3krRQitSPEvOAg5JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:xCowYIurMr1wrx5-NWCETOR7KPWqkf3gqASIqYgxZWUnsTzqXN013Q>
    <xmx:xCowYFZYuQfMvhW77f596BUlSPAooiqOrejbMaavuLpdedBqjlWKEA>
    <xmx:xCowYPak0w5jhe8JgGXGNMtTFSGc3h0R-u-SFSmxjQ3acbJU7HHCmw>
    <xmx:xCowYACPdyST3kbInVeYB5jsSTXYPMO1kOAoWsdFhZmYzsme_Oa2SQ>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 41E7D240057;
        Fri, 19 Feb 2021 16:16:52 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: rtl8192e: rename Reserved to reserved in delba_param_set union
Date:   Fri, 19 Feb 2021 16:13:58 +0000
Message-Id: <20210219161400.29316-4-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219161400.29316-1-will+git@drnd.me>
References: <20210219161400.29316-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses lowercase for a field name to be more consistent with
the rest of the union.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_BA.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index ae4f117c839b..a482cb3b081d 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -42,7 +42,7 @@ union delba_param_set {
 	u8 char_data[2];
 	u16 short_data;
 	struct {
-		u16 Reserved:11;
+		u16 reserved:11;
 		u16 Initiator:1;
 		u16 TID:4;
 	} field;
--
2.30.0

