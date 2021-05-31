Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840E0395E20
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhEaNy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 09:54:56 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:28316 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhEaNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622468095; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZMN1PWn/TFkfI9Dl6YVPmHIm1UhTF1EJg9KXxSbWUsLbnNWMZR00I8COi3u8WDMByn
    CEfDJOuq9H82aTFxo3+WZIGxKl8bbT9qsZlfAn59lqQEwY7Vrb1IxZa2sMm/SldFGpTW
    WBrXoqRmmPyzfGpeS+rTA82KOlO2XBIJzOKiDr/ArooPWyMnj9axtYqV53UrUSrnNSOi
    nz7Zy3AdWOuNYTHZ8MgGirp3YXBaEQpv4U2rueN/xoVjgN4b5whkwgzY5JL2EzAtaiq/
    kKv/teB4C2a+eEHbNUaI4unXNQbe/cvH3X2E06C22me8IYww3KpnpFeGJA8394i2SJBI
    CQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468095;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QJ7EL3rdKbTeB2eISpfKJ6qyYsqnmKEy5taAecFN25g=;
    b=NMxVLxcoFDgEKStNYRv7rXEo98FLcgCfjTw+h8ooJXNjXb3/35Pzo1hCLmRMdnjntN
    EAHdImqAth9K4F+1LmcAmxVeLFs8ya7Jv7wL69jMERgkltIiGxzm/izZ7AUw68qYCGrR
    Q0mDw60cZeHsbOaikv1dcdmSeFVuVDnWOQBqlAb4grYlRup2IQ0oOjqZ6XbcEYF9hcNx
    rrYiOgaYvIfF42jo1RFCxZzHTIyv8C5wIm/F59xC50LzqDLL8WU9N3DS37mYlKh28H+i
    CXd+P2MDw0/8oMqNhyBywTOYuzClByBr/e5YiZk9vgnhiOoTdccbyZzbusPIJZkt6nPh
    QceQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468095;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QJ7EL3rdKbTeB2eISpfKJ6qyYsqnmKEy5taAecFN25g=;
    b=W/8CMJpkxLvLFegqBBZxCvR5VWFJ3g1PJgxETg567ubrIcEL2U6n3RNuG2t8/SGW2F
    eJ+4KcKy2e6xW+J0kxF///r93M8puqRKOG4AbEOo71fR7tXHLiiLkjIHp+yjGPE3q27s
    TmJN74fpmPxoUMrkCA/x5kA81jfAPQwn1IWbMwsVQWEbA+HboPOlzzxrWWH3qPbK1sKe
    92r7XwxWcuHEYMCTxgZSvYAKSsBCD9DFlp4YJQrcP+TtmTbczzccJVeWHcOcmfwX98F5
    LMXt9dt1TapQpZ4lMlNgGJo7K2O50fkhGblAhaL0NlWFJ9wsHhby1es1v6wjzQpwpXbj
    fSNg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526Kcak="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x4VDYsKxA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 31 May 2021 15:34:54 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 3/6] extcon: sm5502: Drop invalid register write in sm5502_reg_data
Date:   Mon, 31 May 2021 15:34:35 +0200
Message-Id: <20210531133438.3511-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531133438.3511-1-stephan@gerhold.net>
References: <20210531133438.3511-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sm5502_init_dev_type() iterates over sm5502_reg_data to
initialize the registers it is limited by ARRAY_SIZE(sm5502_reg_data).
There is no need to add another empty element to sm5502_reg_data.

Having the additional empty element in sm5502_reg_data will just
result in writing 0xff to register 0x00, which does not really
make sense.

Fixes: 914b881f9452 ("extcon: sm5502: Add support new SM5502 extcon device driver")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/extcon/extcon-sm5502.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 907ecd01ebb7..9f40bb9f1f81 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -88,7 +88,6 @@ static struct reg_data sm5502_reg_data[] = {
 			| SM5502_REG_INTM2_MHL_MASK,
 		.invert = true,
 	},
-	{ }
 };
 
 /* List of detectable cables */
-- 
2.31.1

