Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF1E3F5062
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhHWSb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:31:56 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhHWSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:31:55 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZTa2-1mVuDg3Nby-00WUNm for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021
 20:31:10 +0200
Received: by mail-wr1-f49.google.com with SMTP id z9so27509499wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:31:10 -0700 (PDT)
X-Gm-Message-State: AOAM532uZUaB+068QuBZKjb9wHXyixN3celQV7jZFzuPmq8PN8WmtR8P
        9J6iqfPVXS2UuNou/lkxhjltXG96vQp1tfhCUzo=
X-Google-Smtp-Source: ABdhPJzGA0liIWmhFS6fLWzMMI5k/OJABuW+2cK0Y3FOAEuICkoNZE6+q2cBGPHS04Aeqah9kCHLMLsyFiVqcDJzDZo=
X-Received: by 2002:adf:d1c3:: with SMTP id b3mr13832639wrd.286.1629743470516;
 Mon, 23 Aug 2021 11:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210823143122.253094-1-marcan@marcan.st>
In-Reply-To: <20210823143122.253094-1-marcan@marcan.st>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Aug 2021 20:30:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3QV3fj=ZpwNAQ6JK=W56C4W-T9-jZXDq=Lenrq6O2RiA@mail.gmail.com>
Message-ID: <CAK8P3a3QV3fj=ZpwNAQ6JK=W56C4W-T9-jZXDq=Lenrq6O2RiA@mail.gmail.com>
Subject: Re: [PATCH] mfd/syscon: Use of_iomap() instead of ioremap()
To:     Hector Martin <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DmxGLdR8Hq+onuGyCobHsFrpMvDDQLpROfLY17bKgW9qobpNAOP
 G49IMu9szs8+4qfHl3ljOk/EmWG0gVNi4Zt6zj24GAQRacm7cTJDAboBTrS3bZxTMoNIRoi
 KypxaVby6up50vP+/m+mf9J4pCttVUe4/u6aTcU1Kg4tSz64Q0sKoOToPEwZ4VJiT+w6Cs7
 FGuOxth0KDZm0+KU3q2Cg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e9YImvc+pM0=:ARo6TV/0v++LU613uB+x52
 Z0k/QgiKQl2JnhThExdxgZ080U3hGoU6dWMNgbomfodTNraYKnNIJDPsEt/CS0afWavUwjWcO
 avk2bjxHssVKZrgWK6JxKNOU1oJNefTeWp5DFKVO0GtnLc3unFMJOSsPOFMrA2O4+z4S0Db8r
 81HTZPow0qiSrGyDEUl5PbUZkSuA/jO4EgQHi+hvuaKpZWv2AggJHNBnJGuczzHeZI17VNtWM
 KN2BoiRsw9Axl44Clk9MaTBJDM6QRn7rmeBFxc5rfgd3BTSk79JUfkDSyNEAfDdEiYJMcHv3O
 90BEU+Iyk5NJNCwztQNCr4iSe3OQLaF3C96hz6QrsAvX8Ku89YLzKnD6TLuwduiWp4S1Oz5Pk
 +Qn40GUXZ8D+O/sxzDUxuw8mS1UDpY5p8Wo9+/pySJmHPMcolDSinLcIe7mgvUSdjBE4TS2j4
 Id3CvCBSKEUEc/cO8pnNMnviPxrdrvNPglh4uEQ6VEstrGhrMimsffF04j0V46SiiQSGQVXZN
 BsdfJNdlwrcX1ZDOEMGBPBENWGsLVPCLqWvKAw+nX3uwwywrEw1EAvb1vY3gqFMucla0RKO+H
 9mM/u41UXXS/SbozD4eGD2DqivWqEHzpKoeuWJRjpW/dszGYlGCy+bqO1iLeLizGccWbmTtaw
 CvwVS4O8OOlP3IcOYYTuRZGlvnWzy49sj97jp3uGuyR0nDsyVzwS+uvsj7GCRQDft8INUpUx3
 bKfAIdbzIHTJ6jpszs1u1t+Smj96ExXx1+39gKFxCsWEGw2BAMN5bILzUyRxiQ6W5xYfZmLjk
 L23hjrvD1lNut8hmgmiaMaHPNh03wQqHHRxEdEqgWi+FWw8PGWKZzVIMC8Rc29laNWG6L6n
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 4:32 PM Hector Martin <marcan@marcan.st> wrote:
>
> This automatically selects between ioremap() and ioremap_np() on
> platforms that require it, such as Apple SoCs.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Lee, please apply for 5.15 if it's not too late.
