Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70AC412F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhIUHK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhIUHJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:09:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33873C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:08:28 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 73so46469349qki.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kfDlQBVSqf07hAXhTAUKnH/OI2lCXLrpWHu75WLFvTA=;
        b=BUinGRzkEBTD99Lt746jvIe5+HpRg6p8cNDmB77n2y2EAdYUKS2BHXSsu2VZElC1d2
         ygjjAt+20xmsTf2+CowQNYCkQ7LpWVOLcNWqFzr8sMeUZYIRNrSel43BcJ97tHdjEwFH
         WssQkSZgvJPzBLfbVd+umz91/u0wIqmcZjOk3IWi/GRJLfK76Kq0EqGGwd87pJC8wlZS
         twCN7GWSsEhfKlLrgOYUC7NoeOx2tLdagfbj8wGnqqWRjE/9+vuxkWUAfkwVX6hpkd59
         2V3aBqYY0j17LWPE8oCxEqfZcIDcNsNnsX4c0/r4RINDh3gbMJZPpSQcxFd0u5ijJE7M
         J9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=kfDlQBVSqf07hAXhTAUKnH/OI2lCXLrpWHu75WLFvTA=;
        b=otsV6adhB1b9y9pRdvo0lKH6jtXz+IH0/UMTbYl1xqkQ1n4de9D+RRaklO9KcOhY9+
         EOvVhe5hEyLlp2MsudZNihd6CHBqMwNdgjO0oeYv73W1SSL8H3DPcPBHe08NPyEpb9WI
         XZ51u4pTG4OAnYDRvAFGAJM65kkDWJkBasa1HLBFsct3+Ao/e/8lunF869uKvLEW7Zfl
         avIz31/KaCxeLLrxndASarYs6H9sSF0slO7fytivqdCg7BLiDy5c6wD+RHCOrpkiEAqa
         R4Ky3XTdQ68b2umCOXqUNVUEgAcX4An9o99TNP3u/4tKe2ffC7od/ehdgcMC9JPyvBtj
         h65A==
X-Gm-Message-State: AOAM5306BFtIvgZjuQXmNHTiZb4u97X4srEpOlbPcbs1CYiuMbiIqqEj
        r23aulzvfB9HFmoeYKyS01z5hq8sxGQLybXledA=
X-Google-Smtp-Source: ABdhPJwky0X1WaQsaBvgbits30v4OowUnsKYU21Vxz1f6NWZNUQIksXggH3g/no4jfcIMl7xy4pX9URKIP26EpiKmMQ=
X-Received: by 2002:a25:cc90:: with SMTP id l138mr35822464ybf.400.1632208107095;
 Tue, 21 Sep 2021 00:08:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:d290:b0:5e:224b:aff1 with HTTP; Tue, 21 Sep 2021
 00:08:26 -0700 (PDT)
Reply-To: michaelrachid7@gmail.com
From:   Michael Rachid <torrescorey23@gmail.com>
Date:   Tue, 21 Sep 2021 08:08:26 +0100
Message-ID: <CABmOKHoRd2h_QckW19kM1YUhre9SqWEra04iPSax_OPBNtb2Kw@mail.gmail.com>
Subject: =?UTF-8?B?15TXptei15QvUHJvcG9zYWw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15fXkdeoINeZ16fXqCwNCg0K15DXoNeZINeb15XXqteRINeb15PXmSDXnNeU15XXk9eZ16Ig4oCL
4oCL15zXmiDXotecINeU16bXoteUINei16HXp9eZ16og16nXmdepINec15kg15HXlCDXlNeZ15nX
qteZINeo15XXpteUINec15jXpNecINeQ15nXqteaLg0K157Xk9eV15HXqCDXkdeX157Xmdep15nX
nSDXnteZ15zXmdeV158g15PXldec16guINeU15nXlCDXodee15XXmiDXldeR15jXldeXINep15TX
m9ecINeX15XXp9eZINeV15zXnNeQINeh15nXm9eV16DXmdedLg0K15DXoNeQINem15nXmdefINeQ
16og15TXqtei16DXmdeZ16DXldeq15ouDQoNCtee15nXmden15wg16jXkNeX15nXky4NCg0KDQpE
ZWFyIGZyaWVuZCwNCg0KSSB3cml0ZSB0byBpbmZvcm0geW91IGFib3V0IGEgYnVzaW5lc3MgcHJv
cG9zYWwgSSBoYXZlIHdoaWNoIEkgd291bGQNCmxpa2UgdG8gaGFuZGxlIHdpdGggeW91Lg0KRmlm
dHkgbWlsbGlvbiBkb2xsYXJzIGlzIGludm9sdmVkLiBCZSByZXN0IGFzc3VyZWQgdGhhdCBldmVy
eXRoaW5nIGlzDQpsZWdhbCBhbmQgcmlzayBmcmVlLg0KS2luZGx5IGluZGljYXRlIHlvdXIgaW50
ZXJlc3QuDQoNCk1pY2hhZWwgUmFjaGlkLg0K
