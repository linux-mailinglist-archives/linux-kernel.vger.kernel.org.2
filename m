Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0EC3DA77D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbhG2PXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbhG2PV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:21:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8FCC061796
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:20:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d17so7351847plh.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tdNjnBc4RF2XtBwajp3W7kHbfRpeeIvDsQFfz3mxyCM=;
        b=m4oRZDoL9QWM7PqByQsp2SSynDAZ29dLqe8gWq+l8+AAnqzXq1cjpuyNpcBMBMyc7E
         /lc9bWS5Is/1NWjKwq4b59W2maJcXhS3ZbsXKuwz9LwFNCoxm7CFf14VIoH20quFkQPu
         29jh4CPqESoHfyJKx3Z/OfIEs3iuOvNynuTXwIsvRWIu/C0F0BXXNr8ZTjgMwdMI2/De
         3Y4Y6YKx0WrHSBjS8o+N77fo/mVzWEym/8PK41ZT0ph+Z7ZHvTYJhj1jKVXV9hWSKRzm
         s5zl/0FYjYwlRaw6XLxTHky0CAQGNjRppo5CbDwj+//tNmS69iNGOJjGEIykNt5fZLcf
         etzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=tdNjnBc4RF2XtBwajp3W7kHbfRpeeIvDsQFfz3mxyCM=;
        b=foIiMBXiUeVnUjDKm2no3XKVG1L/P5BPm10aFTS5//ezvihoPh/IMVUNLGc+kOY1lN
         kYD1wRoRxBzpObvRdYphkypjPuh0SufpIXGlxEjXlRFjxW3EUgiiwCzRGEzB95jzAsuV
         b1CvXQCCY1ltvpgMNopP3bLo3V5d8Cp4x6dI4nshzbWBEMRucuvVUSA30qydj0VnLPht
         mjmbc1Fc8Tm4yknwvjBJX5H9Auy8vcvgvBKa7bTM+4AqR9NCMK3BVOndtSk0tarlqFJi
         TK0Bh0fgulfaewbwyc/TiXryqcaTIpfjXbBY87pNDCvA8YueicoyI913EtXXzX6xigLb
         OLCg==
X-Gm-Message-State: AOAM532vpb1WAGvAvtMCwlCBIvKUeWgJuL1jJz6TiOUHVF4/ak8rnTf1
        JH7kjCxMA+0IQ8EJin8ZvQCtFAloJOBftJqX8Kw=
X-Google-Smtp-Source: ABdhPJzVBgm80pMyDxSTXm+HrTtWzSdvHRffRWVV+SEoo+jffCKRZDmhmIPbdQmZ4wxQNl/boeWly6YqTMQp8YZES6w=
X-Received: by 2002:a17:90a:c8b:: with SMTP id v11mr15151250pja.114.1627572014204;
 Thu, 29 Jul 2021 08:20:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2909:0:0:0:0 with HTTP; Thu, 29 Jul 2021 08:20:13
 -0700 (PDT)
Reply-To: donaldcurtis3000@gmail.com
From:   Donald Curtis <nambouriben@gmail.com>
Date:   Thu, 29 Jul 2021 16:20:13 +0100
Message-ID: <CABsiibc73QdrF8ZJwUQVQidcOPSjoNFXDj0GUNzkN8LA_vXyxw@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEksDQpHb29kIGRheS4NCktpbmRseSBjb25maXJtIHRvIG1lIGlmIHRoaXMgaXMgeW91ciBjb3Jy
ZWN0IGVtYWlsIEFkZHJlc3MgYW5kIGdldA0KYmFjayB0byBtZSBmb3Igb3VyIGludGVyZXN0Lg0K
U2luY2VyZWx5LA0KRG9uYWxkDQoNCuyViOuFlQ0K7KKL7J2AIO2VmOujqC4NCuydtCDsmKzrsJTr
pbgg7J2066mU7J28IOyjvOyGjOyduCDqsr3smrAg7Lmc7KCI7ZWY6rKMIOuCmOyXkOqyjCDtmZXs
nbjtlZjqs6Ag7Jqw66as7J2YIOydtOydteydhCDsnITtlbQg64KY7JeQ6rKMIOuLpOyLnCDslrvs
nYQuDQrshpTsp4HtnogNCuuPhOuEkOuTnA0K
