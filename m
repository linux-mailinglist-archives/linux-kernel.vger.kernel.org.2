Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44495401899
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhIFJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhIFJIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:08:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A7C061575;
        Mon,  6 Sep 2021 02:07:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y17so5131894pfl.13;
        Mon, 06 Sep 2021 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7TvTCAQAKWGsSR90jk8cgr0doCoZwdzVQCvvtv6JSzU=;
        b=SoFOcLd2b5JNE80CYq2/ba/SX8C6n+g/tuwwUSeHe4CmGZ05rORjqIqjdqVvYBxlNs
         BIT5b5F73MyI2DiF0m8U2Ll3uz6WnULYATapd0NgD1rOtPphuofEpRtUpajpRkSERNAB
         88umh9itDc4rIvpoAIYNWcIV+4vBqJn1pN1RG46fHyxRDmDaOyb2Fm4DMmED+Ad0uz6P
         cgQPkRgOG/9EixCCtRT72Snj/f/s1lSKK1d+U3mYAGwg1qcDWdV+xrF8j9VEzBb9XNfw
         WHoAzqfM9XxQAmLELEpicU0MzXR5ByzMhDZKeUoxvzqi5cphKQ3BpS2WPzfoPMQPuS+j
         cCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7TvTCAQAKWGsSR90jk8cgr0doCoZwdzVQCvvtv6JSzU=;
        b=tj4qpaMW70olpCDdiI4DS0wHAD7Uvg8xhHZlUvQsWE76vgIWHj+udt3jIBtdS/66l1
         701+1jKVLwNB1hnEf2WsdcxyHv6tpTvvXt6mBH+xkJ0s2msZiMN9fQ4iaOhPefZyALs8
         FS4DWSLT3LP1Y4fiTS3RfehaHX5E+row7OGi4btaXmMKsg6QTYs1XkzC7a4jUlqKWKEJ
         Cx4LAoap+RSmBZVkrIlxuvaCmM9SwByg8Q0fcmVuNuzNRBFgjILQrQdfEK5nYyJTLxDy
         w7yVnKj8Ul6iNgYdlptDzkxO0ByXnqBFQezUSPVwX0MXVxT2iYJUGo0IhDhUJpVxloZR
         jDMQ==
X-Gm-Message-State: AOAM5316r8rFgtxANlydjN/NIkOQRV8PaW/WCYfXK8QAHsU2StNnqVzj
        G3wytjj2nuM5NAvlWtVmFmVjm2lojG1ao3jCcFM=
X-Google-Smtp-Source: ABdhPJz9/3ZOZ03+sae5raOlBsnWSXNV1XhZcCe9pKR8e9TswPMP26OqQrn91tBBIEKrzOCq1c15BcU5cLjzNY8n+/g=
X-Received: by 2002:a65:5a49:: with SMTP id z9mr11387468pgs.121.1630919219912;
 Mon, 06 Sep 2021 02:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210825154817.242411-1-junhuahuangdream@163.com>
In-Reply-To: <20210825154817.242411-1-junhuahuangdream@163.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Mon, 6 Sep 2021 17:06:49 +0800
Message-ID: <CAMU9jJpq+Yz+hCrGGWa+c619YgFzwqTRF-m9s_R=V7jFHak1uw@mail.gmail.com>
Subject: Re: [PATCH v3] docs/zh_CN: Add zh_CN/admin-guide/sysrq.rst
To:     Junhua Huang <junhuahuangdream@163.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Wu X.C." <bobwxc@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Junhua Huang <huang.junhua@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Junhua Huang <junhuahuangdream@163.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8826=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:13=E5=86=99=E9=81=93=EF=BC=
=9A
>
> From: Junhua Huang <huang.junhua@zte.com.cn>
>
> Add translation zh_CN/admin-guide/sysrq.rst and link it to
> zh_CN/admin-guide/index.rst while clean its todo entry.
>
> Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Thanks,

Yanteng
