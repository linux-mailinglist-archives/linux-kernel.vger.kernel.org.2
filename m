Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A532B3587E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhDHPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:11:09 -0400
Received: from m12-14.163.com ([220.181.12.14]:35878 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231848AbhDHPLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=O4TyM
        S8YfxobpEZUkp6vaV60Ue/gWDxGvZkMc6y1mjE=; b=cDxAkXeMNdmaw3EuoDIiG
        QDcaO9qfwSHaLhh2hhgpJ6+8xeo7h2qQ1Wcpci3GH4UW+jaExbfycVSj88XO1YvJ
        gvCLP1TdBc/zo1K0Wcbm1azKQ2LO3UEKd2QBg30MAHbFXVFZA12rp7dEd+yoCoYn
        nQZpSlbYo7UQtUOdZIk5NY=
Received: from localhost (unknown [120.229.91.80])
        by smtp10 (Coremail) with SMTP id DsCowAAXJX55HG9gi0KyCQ--.11907S2;
        Thu, 08 Apr 2021 23:08:42 +0800 (CST)
Date:   Thu, 8 Apr 2021 23:08:49 +0800
From:   Xuezhi zhang <llyz108@163.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: panel-dsi-cm: convert sysfs snprintf to
 sysfs_emit
Message-ID: <20210408230726.00006836@163.com>
In-Reply-To: <YG8BnO1pVhDKCS3F@orome.fritz.box>
References: <20210408085257.2396-1-llyz108@163.com>
 <YG8BnO1pVhDKCS3F@orome.fritz.box>
Followup-To: dri-devel@lists.freedesktop.org
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DsCowAAXJX55HG9gi0KyCQ--.11907S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary8Ww13trW3Kry8ZryrJFb_yoW8Jw1xpF
        ZxK3W2y3ykXry0ka9rWF1xZFZxu3WxtF1UtFZ0y34YvFyYvFyUGryqkr45WF17uw1Ik3WY
        qF4agrySga45Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgIDcUUUUU=
X-Originating-IP: [120.229.91.80]
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiWxpuhVSIpmQPRQAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 15:14:04 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Thu, Apr 08, 2021 at 08:52:57AM +0000, Carlis wrote:
> > From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> > 
> > Fix the following coccicheck warning:
> > drivers/gpu/drm//panel/panel-dsi-cm.c:271:8-16: 
> > WARNING: use scnprintf or sprintf
> > drivers/gpu/drm//panel/panel-dsi-cm.c:251:8-16: 
> > WARNING: use scnprintf or sprintf
> > 
> > Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> > ---
> > v2: change snprint to snprintf in subject.
> > ---
> >  drivers/gpu/drm/panel/panel-dsi-cm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)  
> 
> Nit: I suspect you might've just resent this from some private email
> address, but it's kind of hard to tell because you haven't been using
> at least the same name in both email addresses.
> 
> However, if you're forwarding this patch on behalf of somebody else
> you need to add your own Signed-off-by: line.
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Hi,
   the email address of llyz108@163.com is my private email address,
   and zhangxuezhi@yulng.com is my company email address, and Carlis is 
   my English name ,Xuezhi Zhang is my Chinese name, i will use the
   Chinese name to send the emails and patchs in the future.

thanks,

Xuezhi Zhang

