Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2741CD70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346745AbhI2Ugc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbhI2Ugb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:36:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F05C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 13:34:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bd28so13218919edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=fVc4u3M27ejIgDXMiIJmY+yuSVPlHRgNnqreciJj6Ho=;
        b=dx3Z3A7TSRkykEEPXeJt1H/u4VR89cnkNQhTbTWnj/WQJ++64lbCNBTNGx4+mH5hG+
         03wH/S57u9JyrvlUK5cVWRbE5XDWIzvkl2LhM12H7SxNddwOfJUPr9cRITf+KnXeMw4k
         nvI/+Q2kZGKW2QDldEYH4xLK+9u5F/EEypkK0A7QKxKERjeMzhh+SWH9z+EcoyUPkSvW
         o9U1g7/dMUvQVJRNvvDEGSqguRJdyWMA44a07iAyjaVEw3XZ5HHh438btt6dNBBlILa9
         swns6595g5pklMXMY4lqlAXqjM0d8CF9vrSdPW81kD6V5J5zxv6QgcS4vm6mrAWKV/8V
         RzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=fVc4u3M27ejIgDXMiIJmY+yuSVPlHRgNnqreciJj6Ho=;
        b=S26BFrp0NOW1jrXOAYocKBdFfdY2UJvLPRkTt721qvUfH8n/5MWId1o1c8D8UfBhvo
         EiSmsQ55BvsW2PauYt1ai+MOqVToVMvWH5EcFumdZFDbzqS6oeCQTw0KycvvvJPHlgXL
         ZEPXB0AxBd5vpA+7OJX5XbXPQ+P/+k8EKn3uGlABtkaFVVZJyM25YWCp4rieyP4UMKuA
         n6KeqDWRAizFHLKTlkqkMTfz1W/2EwEOy86tmxXxeTZNMMkb352U7PS6QmG+lht2IQie
         YIev1LQlhom9VGvGy8vM5W6+DdzW5lOq0+xzDa5ICUOiJDNHn1zdrBbChAF/KX3KHdiB
         V3Qg==
X-Gm-Message-State: AOAM532niftXqdHGmusDlAtA5kWEnpDU3B9GUnYti6LWTmpOLI+6NBht
        dEG71t91g5st8j1OIzgM8UE=
X-Google-Smtp-Source: ABdhPJzI+MppeVMsrWc2OPKcwXh7oBcczDCRmZ0p8DEobNyxaGuVaJs4vKste000YngZaw39Vkq2CA==
X-Received: by 2002:a17:906:b08e:: with SMTP id x14mr2256239ejy.40.1632947688656;
        Wed, 29 Sep 2021 13:34:48 -0700 (PDT)
Received: from kkobus.whirley.local (94-214-33-179.cable.dynamic.v4.ziggo.nl. [94.214.33.179])
        by smtp.gmail.com with ESMTPSA id kw10sm490022ejc.71.2021.09.29.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 13:34:48 -0700 (PDT)
Date:   Wed, 29 Sep 2021 22:34:46 +0200
From:   Dawid Esterhuizen <desterhuizen@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Statements should start on a tabstop
Message-ID: <YVTN5i8qwjlGwOPp@kkobus.whirley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This path fixes four checkpatch.pl warnings:

Statements should start on a tabstop

Signed-off-by: Dawid Esterhuizen <desterhuizen@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index 2e6afc7bb0a1..bc1287cc853e 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -182,11 +182,11 @@ struct sta_xmit_priv {
 };
 
 struct	hw_txqueue {
-	/*volatile*/ sint	head;
-	/*volatile*/ sint	tail;
-	/*volatile*/ sint	free_sz;	/*in units of 64 bytes*/
-	/*volatile*/ sint      free_cmdsz;
-	/*volatile*/ sint	 txsz[8];
+  /*volatile*/ sint head;
+  /*volatile*/ sint tail;
+  /*volatile*/ sint free_sz;	/*in units of 64 bytes*/
+  /*volatile*/ sint free_cmdsz;
+  /*volatile*/ sint txsz[8];
 	uint	ff_hwaddr;
 	uint	cmd_hwaddr;
 	sint	ac_tag;
-- 
2.33.0

