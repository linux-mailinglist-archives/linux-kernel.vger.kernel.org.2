Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E363D3CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhGWPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:12:00 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:51338 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhGWPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:11:58 -0400
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 1A1C57A003B;
        Fri, 23 Jul 2021 17:52:31 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [Nouveau] nouveau broken again on Riva TNT2 in 5.14.0-rc2
Date:   Fri, 23 Jul 2021 17:52:28 +0200
User-Agent: KMail/1.9.10
Cc:     Karol Herbst <kherbst@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>,
        "dri-devel" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <202107222122.05546.linux@zary.sk> <CACO55tvq0Ksm6x_L3r6B8KhYR6dTqb=xzPaRzAeQgaBnff_sYA@mail.gmail.com> <CAKMK7uGee+A2hzY8meXnBAWDuQGs=c=3oww8-JxMJWxF8_kR=A@mail.gmail.com>
In-Reply-To: <CAKMK7uGee+A2hzY8meXnBAWDuQGs=c=3oww8-JxMJWxF8_kR=A@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202107231752.28531.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 July 2021 09:26:10 Daniel Vetter wrote:
> On Thu, Jul 22, 2021 at 9:51 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > hey thanks for the report.
> >
> > This is a known issue and the fix is pending in drm-mist-fixes and
> > should land in 5.14 soonish.
> 
> It just landed in Linus' tree yesterday, please retest that or -rc3.
> If it's still broken it's something else.
> -Daniel

Thanks, it works!

-- 
Ondrej Zary
