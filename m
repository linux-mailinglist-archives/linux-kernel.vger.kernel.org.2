Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D78403487
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbhIHGvf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Sep 2021 02:51:35 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:53993 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbhIHGvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:51:23 -0400
Received: from wwinf1e33 ([10.232.35.107])
        by mwinf5d85 with ME
        id rJqE2500W2Jhpnu03JqE83; Wed, 08 Sep 2021 08:50:14 +0200
X-ME-Helo: wwinf1e33
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 08 Sep 2021 08:50:14 +0200
X-ME-IP: 80.77.224.234
Date:   Wed, 8 Sep 2021 08:50:14 +0200 (CEST)
From:   Marion et Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reply-To: Marion et Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     minyard@acm.org, zweiss@equinix.com, andrew@aj.id.au,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Message-ID: <450800047.345.1631083814685.JavaMail.www@wwinf1e33>
In-Reply-To: <20210908062719.GO1957@kadam>
References: <ecbfa15e94e64f4b878ecab1541ea46c74807670.1631048724.git.christophe.jaillet@wanadoo.fr>
 <20210908062719.GO1957@kadam>
Subject: Re: [PATCH] ipmi: kcs_bmc: Fix a memory leak in the error handling
 path of 'kcs_bmc_serio_add_device()'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [80.77.224.234]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~||~||~|
X-WUM-REPLYTO: |~|
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


 

> Message du 08/09/21 08:28
> De : "Dan Carpenter" 
> A : "Christophe JAILLET" 
> Copie à : minyard@acm.org, zweiss@equinix.com, andrew@aj.id.au, openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
> Objet : Re: [PATCH] ipmi: kcs_bmc: Fix a memory leak in the error handling path of 'kcs_bmc_serio_add_device()'
> 
> On Tue, Sep 07, 2021 at 11:06:32PM +0200, Christophe JAILLET wrote:
> > In the unlikely event where 'devm_kzalloc()' fails and 'kzalloc()'
> > succeeds, 'port' would be leaking.
> > 
> > Test each allocation separately to avoid the leak.
> > 
> > Fixes: 3a3d2f6a4c64 ("ipmi: kcs_bmc: Add serio adaptor")
> > Signed-off-by: Christophe JAILLET 
> > ---
> > drivers/char/ipmi/kcs_bmc_serio.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
> > index 7948cabde50b..7e2067628a6c 100644
> > --- a/drivers/char/ipmi/kcs_bmc_serio.c
> > +++ b/drivers/char/ipmi/kcs_bmc_serio.c
> > @@ -73,10 +73,12 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
> > struct serio *port;
> > 
> > priv = devm_kzalloc(kcs_bmc->dev, sizeof(*priv), GFP_KERNEL);
> > + if (!priv)
> > + return -ENOMEM;
> > 
> > /* Use kzalloc() as the allocation is cleaned up with kfree() via serio_unregister_port() */
> 
> The serio_unregister_port() calls serio_destroy_port() which calls
> put_device(&serio->dev). But I wasn't able to track it further than
> that to the actual kfree().

Hi Dan,

Checking this release path was not the goal of this patch.
It was only about the VERRYYYY unlikely memory leak.

However my understanding is:
kcs_bmc_serio_add_device
--> serio_register_port
--> __serio_register_port
--> serio_init_port
--> serio->dev.release = serio_release_port

And in serio_release_port:
struct serio *serio = to_serio_port(dev);
kfree(serio);

For me, this 'serio' looks to the one allocated by 'kcs_bmc_serio_add_device'.
I think that the comment is correct.

CJ

> 
> Is there a trick to finding ->release() functions?
> 
> regards,
> dan carpenter
> 
> 
>
