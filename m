Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8390C43AFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhJZKKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhJZKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:10:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB94C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:07:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u11so10299324lfs.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=SdeQLGcX9mvI/gMbFbBsioglPQKFAJY8wprEGUZOknk=;
        b=BtEdPOUBDGKGTAIGzBmkIm5j/koolemuxKOkZDK7p4w8hfbea92F81mZE7qrTwJ+Vp
         dSTnEdYWgauDIDODI03Su5LA+OOVOjZAI1xwkIDEwAqtGhY75kxMZWzqQVRybg1+lyXv
         fKEhuZd6tRZXOmn8ogkHEsNfB07BBSSVAByo4/McPX2ABsBQeSdqowCZcDukurYbVGus
         xHxsb9RydApBJGUhaTmdiPmWv4yg/guJUpVAQxGfLwX9ww8FjyiO1nj2ISNS+Ge0RRXG
         z6Cwh/c7FURw7eBPGR88uFiJkLexqBg4VCFOiXLUH8x79sXRGQKj+g5Y14yj1Pe1JuS9
         TIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=SdeQLGcX9mvI/gMbFbBsioglPQKFAJY8wprEGUZOknk=;
        b=zhq6e6Md8acQgSx6rdvInNs30q+hJ3+yK6GqAjvGmhZmwRuepZzOexAYolefNlzDMK
         lZOJgxgW04wjK3JmbGrsuHEhS8nhM5HCio3eByI91/kQ5ogA2l7vyTrbGNHSmsYQbyQ/
         t1BjuJ97Qg32Jqz4C1LDYCtWkBB+X+GUaWb4jj/9zf6WdkQLYDvSwoGrsglg6B1t/h3O
         /bSqbtkFFNuwT0uOrlsR0kXdyB6FoCqDhxGOGC2c8TpRJK1F7UBo4hrh8VDbuEiViut0
         L39V3/5pJaFzy/KpPZcYx4cRnnKSAhVQmzBxdEz/g66K0b75cBCb0tqflnINCahPnYlv
         W0Kw==
X-Gm-Message-State: AOAM532+Ps8RwbkfAzO9YqUvAKbF3Ep6JzldTlX43nz/dw/WXe1rU+6/
        29GiKnRSsQAat/+BM8/gVexYbqkhh0O0lFPeJFs=
X-Google-Smtp-Source: ABdhPJwjvnWWIrKgCIO8NzcZtZrrj0OZW/tuvm1oocV3q/sECgfIoJCLwvFFGKjIB9yCKYKrzK/nxI1xF2FT+FLfCkc=
X-Received: by 2002:a05:6512:139b:: with SMTP id p27mr23170628lfa.540.1635242868778;
 Tue, 26 Oct 2021 03:07:48 -0700 (PDT)
MIME-Version: 1.0
Sender: azanonlavagnon@gmail.com
Received: by 2002:ab3:5b1a:0:0:0:0:0 with HTTP; Tue, 26 Oct 2021 03:07:48
 -0700 (PDT)
In-Reply-To: <CABWLECuf+njyzC+RAJgPSE5YbTYFNC0gdm7FiwxRKdDJYA6PPg@mail.gmail.com>
References: <CABWLECs7v2AO-eRzTfiFo8WVdkp+vTcw+yecrHgrv9cSZfX2fw@mail.gmail.com>
 <CABWLECuhocADMfam+=ONANbxsyQJTR7kERVKsyx=c4vzwo0ytA@mail.gmail.com>
 <CABWLECt1=spfcfvfPfqQSQFv_Ovy8_E1ACQb4ONXEgdWHJdYfg@mail.gmail.com>
 <CABWLECthy-=eCgYdtGUjc2z9q0PDsrCVQHtiJ_nG7ZNFuyY9qg@mail.gmail.com> <CABWLECuf+njyzC+RAJgPSE5YbTYFNC0gdm7FiwxRKdDJYA6PPg@mail.gmail.com>
From:   "Mrs. Rose Guzman Donna" <ebubedikemplc@gmail.com>
Date:   Tue, 26 Oct 2021 10:07:48 +0000
X-Google-Sender-Auth: 583mMtmeu5-mVisfcIHu8V3aViA
Message-ID: <CABWLECvzT+dp1nMEOWZ9C62AeCAQ8LH6MWXfSbmbGHwa3t1F-g@mail.gmail.com>
Subject: Fwd: -Re: I 'm Mrs. Rose Guzman Donna from America.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 I am contacting you because, I want to donate a huge amount of money
to help the  poor people ETC / covid19 victims and to open a charity
foundation on your behalf in your country is OK?. This involves a lot
of money Get back to me for more details. R Guzman from America
