Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B75944D9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhKKQLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhKKQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:11:32 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E602C06127A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:08:42 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id g14so26180517edz.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TpTcTcivucgwkiyqkj1zzJWU3hB8dDNMbilNVwfOU0A=;
        b=LtdK5Amx5i4GwJiyPI0GbaovKcqT30D097sXaA2mohXl1Aqwst0Q18IKF5fh/bx3Dg
         8o4UGh7Lzn6j/uIWZQBAK49zOPEtSyfIPkt+xzB3PAWJ1Z7QqaaMg6ZcPGnbc6ZLRfdv
         89MZI3SRklyOsaD/2QMYv3id42IIGeBBfi4Ljvua2AVT2ssciAOTfjygxaFLo0eRo9nU
         7xeXA9DZgICjMorfCRk3nV/eW8zweFmJdAv+IbsEbwniLh6HxBdMkBtB7JblBlO9UmUt
         XklCA93d/hra84qQYgAPdHoRnmVOJbdcQnJBEXI3Dhx8jyz47+v7tI01c9XM3bUtKQ/7
         V6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TpTcTcivucgwkiyqkj1zzJWU3hB8dDNMbilNVwfOU0A=;
        b=pmsQKsRQh9xO09kjIvP2dNe4yI2nGCWGKBXHkVHt102NzzNw8WDzq8bkkWi/dXgL+v
         W6zcsX+YjKfvSz86m7o4ggggbmFqYRi880PJXqNXk8p6JtK/45PQ27zdtifQ9zk7bAya
         db4oEySpyGQi5k/cYoMghSpJjrQtvlYrZQcPPDpp7+yfbFcJyyL2u2rt9/SyzHBHuycE
         5GscmG2owqShVRKf/Z+8T/W521cc98QZABJHyGLKFNIkZhZxxLJ88f1mwsnbkowFkdfK
         ipLya0orhKq7wppkfi4raMnegVbeAhvpzvgIbEN//YnW1JSvgfUmchVuX1bI0ZhWK+4R
         BeLA==
X-Gm-Message-State: AOAM532KBey08mhD0zCYpVF4njQKOMagZzIs34GPP+bwX3PIunU0CzsT
        3oDz442LQzamtiIxLeEez0RlyYFlRmGIfjN2/r4=
X-Google-Smtp-Source: ABdhPJwEnnTjb/6sP6xjnJNb3GOQUsKDv2oErtVBHk5wljm8/b53DssZnq9WNdvY0eQPZY0/5GA2Tnybehdkj0Fr0vs=
X-Received: by 2002:a05:6402:337:: with SMTP id q23mr11466606edw.189.1636646920054;
 Thu, 11 Nov 2021 08:08:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:3490:0:0:0:0 with HTTP; Thu, 11 Nov 2021 08:08:39
 -0800 (PST)
Reply-To: kathrynh566@gmail.com
From:   Kathryn Hensley <marinavanessa534@gmail.com>
Date:   Thu, 11 Nov 2021 08:08:39 -0800
Message-ID: <CAAPyjrug0ER5JNGQEp6WfRvoA4xd7c2KcDyi2N3-fhn9UBorqA@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5bCK5pWs55qE5YWI55Sf77yMDQrmiJHmnInkuIDnrJTkuqTmmJPmtonlj4oxNzkw5LiH576O5YWD
55qE5aSW5ZWG5oqV6LWE77yM5aaC5p6c5oKo5pyJ5YW06Laj77yM6K+35Zue5aSN77yaa2F0aHJ5
bmg1NjZAZ21haWwuY29t5LqG6Kej5pu05aSa6K+m5oOF44CCDQrosKLosKLkvaDjgIINCg0KDQoN
CkRlYXIgU2lyLA0KSSBoYXZlIGEgdHJhbnNhY3Rpb24gdGhhdCBpbnZvbHZlcyB0aGUgdHJhbnNm
ZXIgb2YgJDE3LjkgbWlsbGlvbiBmb3INCmZvcmVpZ24gaW52ZXN0bWVudCwgaWYgeW91IGFyZSBp
bnRlcmVzdGVkIGtpbmRseSByZXBseSB0bzoNCmthdGhyeW5oNTY2QGdtYWlsLmNvbSAgIGZvciBt
b3JlIHNwZWNpZmljIGRldGFpbHMuDQpUaGFuayB5b3UuDQo=
