Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C3C3D409A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhGWSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhGWSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627067713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5XrbwupJDQkWVogTwSHSYIBsCDDbVdxstoiDOHZL08=;
        b=gvHr5Ri85XreTADAVIbX1bnw6Jsgf7DA3GlA8BWG6CBt9Ig58W67l/0LxNJfPuC3fbRNLw
        E2TgEGqsba3csvFFx84MA8YYJmbux3rNalYut2dyDoqFIpYupT/snqvIH+Qx21NTdSCgLf
        mwBh4tlnAKLnVT0QPXGNdCCK2NgH1Rg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-ENkmI5srOiuEZPbzPie2mg-1; Fri, 23 Jul 2021 15:15:11 -0400
X-MC-Unique: ENkmI5srOiuEZPbzPie2mg-1
Received: by mail-pj1-f72.google.com with SMTP id 16-20020a17090a1990b029017582e03c3bso7274124pji.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=O5XrbwupJDQkWVogTwSHSYIBsCDDbVdxstoiDOHZL08=;
        b=ZM7o6edmKZ7VFhb2zeM8RwTnbNYwqkIp5eYltsF1iz0fEMKtgcXNnNgldyBuKHcOEV
         f9t31WOMCxgkzN4yVKEAXIl4aHhNhokpKjzl1bX5IbSaE/pJ1H4xwCeE1hsofduEqWnM
         iGz9Iaed5S/HLugNZhqWsp0kn4VfZcomhDjvY/7q1wiaGIikL2D7qQkfxGnxcZh2YZm7
         oHDzbpSrHpdgLHhRhrlU08hFkY05FNHOmVEjLfYzYVFh6H6jtRV3+eVDrLCMv+I9JOD9
         idjnL+L1Evwbom4no05xXDFRkhFgg7d21tY5TUbfjcEgAVHOm81XshQv1N3d0RH8Qoyp
         rlpQ==
X-Gm-Message-State: AOAM531N4HJsy7qR6TT7RgMQICbz6nIctDoTBqSI/acbkFKRPvvwCuIm
        /fqypNrkJrKe/GON0zv7rLyHB0fTESnOCCRm8qdaJN1TR1PzCKbb2adjXjbR7di4ZgBss11/0o4
        b9lf2LV+Zvqrof0ydQT11F1U=
X-Received: by 2002:a17:902:7d8f:b029:116:4b69:c7c5 with SMTP id a15-20020a1709027d8fb02901164b69c7c5mr5172058plm.58.1627067710561;
        Fri, 23 Jul 2021 12:15:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkQ5pLDCgArcMZfQ8FeCSAfjrAAzSQEnGlHHlab/u4ePzAnDeOL7r8FRIg02vya3uTbI7MKg==
X-Received: by 2002:a17:902:7d8f:b029:116:4b69:c7c5 with SMTP id a15-20020a1709027d8fb02901164b69c7c5mr5172014plm.58.1627067710258;
        Fri, 23 Jul 2021 12:15:10 -0700 (PDT)
Received: from xps13k.happyassassin.net ([184.71.189.90])
        by smtp.gmail.com with ESMTPSA id hk18sm6706598pjb.41.2021.07.23.12.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:15:09 -0700 (PDT)
Message-ID: <b5d25fba13479cb3aa03f1a054873c122edf7310.camel@redhat.com>
Subject: Re: [PATCH] writeback, cgroup: remove wb from offline list before
 releasing refcnt
From:   Adam Williamson <awilliam@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 23 Jul 2021 12:15:08 -0700
In-Reply-To: <YPsU9/8ZijTjHTWh@carbon.dhcp.thefacebook.com>
References: <20210716201039.3762203-1-guro@fb.com>
         <20210723183343.10017-1-awilliam@redhat.com>
         <YPsU9/8ZijTjHTWh@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.1 (3.41.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-23 at 12:13 -0700, Roman Gushchin wrote:
> On Fri, Jul 23, 2021 at 11:33:43AM -0700, Adam Williamson wrote:
> > Hi folks! I'm not subscribed to the list and am trying to send this
> > using git-send-email, apologies for any weirdness related to that.
> > 
> > Just wanted to confirm the issue that this patch attempts to address,
> > and ask if it can be reviewed/moved along. I look after Fedora's
> > openQA automated test instance, and in tests of recent Fedora Rawhide
> > composes, we're seeing at least one failure per compose that's caused
> > by this crash (it usually prevents the system shutting down or
> > rebooting correctly in a test which requires that to happen).
> > 
> > I can't actually confirm the fix as I can't really easily change our
> > tests to run on a non-official kernel build, and our kernel maintainer
> > (reasonably) says he won't backport the patch until it's at least got
> > some review. But I'm definitely seeing the problem!
> > 
> > Thanks folks.
> > -- 
> > Adam Williamson
> > Fedora QA
> > IRC: adamw | Twitter: adamw_ha
> > https://www.happyassassin.net 
> > 
> 
> Hello, Adam!
> 
> The patch was picked up by Andrew Morton and will be soon merged into the Linus's tree.
> Currently you can find it in the "next" tree (can't provide a hash because it's not stable
> there).
> 
> Please, note that there it another fix called "writeback, cgroup: do not reparent dax inodes",
> which you likely want to backport too.
> 
> Both fixes got some testing and reviews.

Hi Roman! Aha, great, thanks for the info. I didn't see any follow-up
on LKML so I figured it was in limbo. I'll let our kernel maintainer
know. Thanks again!
-- 
Adam Williamson
Fedora QA
IRC: adamw | Twitter: adamw_ha
https://www.happyassassin.net


