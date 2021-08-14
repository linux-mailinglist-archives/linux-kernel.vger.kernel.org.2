Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787B63EC600
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhHNXlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 19:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhHNXle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 19:41:34 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D36C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 16:41:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id h11so21603710oie.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 16:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tfuq+be3Xa5MVH6I90u/6qpYq26wTOLdHeD5oxhu6Ks=;
        b=TrdCHs1Ejepb0mKQvg/IhZlrldX9HB8TvKWpXPb1hrFaQH98zhoMUYZoGz8CVSpLmu
         4pKn8m4sQ+opZd54fL+KwUwCuNnCDr1oQ8zfbtN+yFtgdCN7mep5F30Ru+Ie38mWFvBs
         irQubPYANI5/Q3q49q+ZePV/e48mAmCRGD517kYy1fLol6pJWjZYOX1nN+FV05v/39vW
         JDX6IqsQJC1HZ3qs+A7i5/ZOGowyGcH490SrPvyLGgt8J0B386Alckw8DRamnSyJkRVD
         FfycE1hxRogw/PjmifHsowUj+PFsfMVYPPk8AaPrM9cr+kuqW+Z0Ug6QjroXog409xes
         jxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Tfuq+be3Xa5MVH6I90u/6qpYq26wTOLdHeD5oxhu6Ks=;
        b=P75LQQLt3jvVDDTxOPIWbfdBCfZHdGik6vpr3tJCIaG5OTH/RfDEzkHx3wDdI9tDFP
         EFJDwNwU+WWHQQdHrOMgVoHLCP8zGAwbZpFrl7/Wrz1UmsWlKrmyYbQgU3ysjxVwIY0m
         0JplCBesyzUjTmzQL3Fj0AKL7VmdJsc4j531fI1GjbGJPBBtIX+L8MKrhg6VNyYlph1m
         e4whXbzhdzkY8UeX+a3ax4YdIhnOfltxxs/eNAmGyCO4qu+XI/zTu5tpwQi9GuHuX9H1
         XP4whWbzpjLWUxryw724lQpSGaf/CrnFToYFBrD/V5hsi5mJoPB39pz05xQk3tLnpxT+
         mBrQ==
X-Gm-Message-State: AOAM530zDPmuYEALS3yCGdt3nESTP5s2S79aNsq9LCUK9tnk+/r2rxz1
        WOowQUwbuSYpEwyhNTadUT8=
X-Google-Smtp-Source: ABdhPJwMVUqia/DAvlgtxwKwT9hpbfm1RJ+hAlvcLcmyptIrOVhu1G1ehGBSDx83NVmlXlq9EmT9jQ==
X-Received: by 2002:a05:6808:2ca:: with SMTP id a10mr447223oid.44.1628984464722;
        Sat, 14 Aug 2021 16:41:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y12sm1213884oiv.55.2021.08.14.16.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 16:41:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 14 Aug 2021 16:41:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic: Convert to handle_strict_flow_irq()
Message-ID: <20210814234103.GA828447@roeck-us.net>
References: <20210814194737.GA3951530@roeck-us.net>
 <87sfzb7jeo.mognet@arm.com>
 <87pmuf7j5a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmuf7j5a.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 11:31:45PM +0100, Valentin Schneider wrote:
> On 14/08/21 23:26, Valentin Schneider wrote:
> >
> > Now, the above makes me feel like this is the start of a wild goose chase
> > for irqchips in a similar situation.
> 
> The ones in arch/arm are easy enough to catch (I see gpc, omap-wakeupgen
> and some exynos suspend thing), less so for the ones in drivers/irqchip...

Try:
	make coccicheck COCCI=irq_chip.cocci MODE=report M=.
with the script below. I am sure the script could be augmented if
there is some secondary condition that makes irq_ack mandatory.

Guenter

---
irq_chip.cocci:

virtual report

@c@
identifier chip;
position p;
@@

struct irq_chip chip@p = {
...
};

@i@
identifier c.chip;
identifier f; 
@@

struct irq_chip chip = {
	.irq_ack = f,
};

@script:python depends on c && !i && report@
p << c.p;
@@

print "Found %s:%s" % (p[0].file, p[0].line)
