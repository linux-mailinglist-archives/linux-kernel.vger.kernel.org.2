Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EEE32002F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBSVPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhBSVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613769258;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5YOWjYKKEPw7ARjbo3Y9O1C3wAwe1ANRaLyLA4Al9c=;
        b=UN2tN/wd0iUKbsiYNyVGTRiheC0AamWBU8SxLUscPxtoATU4NDla2g5ZJt34eHjYM2KgtE
        6JcVUw6aUw9GLWAnS+vwBNrJLrMyw+exBR66KH3EslDEhXf7uAnCdXjhroXfs5Ulxadzeg
        wCwFtwZXXKn63P8aETBcoSH/GNuXdYk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Nrl0tmxKOmuafxk7N3UjIg-1; Fri, 19 Feb 2021 16:14:16 -0500
X-MC-Unique: Nrl0tmxKOmuafxk7N3UjIg-1
Received: by mail-qk1-f198.google.com with SMTP id k185so4389797qkb.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=C5YOWjYKKEPw7ARjbo3Y9O1C3wAwe1ANRaLyLA4Al9c=;
        b=X1HSMCIQDnSiByf1blebQoUG596Mj+JpARzh51xYRp4Lp2aQP9YoY06MvS3Rlgwe9e
         K6t2FHVyMxL6VAPf4cz2vYY1iQgPvafYZlR/gcVmmTcLJBDe57+2j43rsRFMniJn0Zdq
         c5vl/BOiQDJWTW4E59f0iffe3TF+VyWsQuIoOqeVuXcxRP8ieGSWp2XUMov1MOvkq583
         BiahbNRPcyRl5b8aEq9d8mXMpMvHy7DySjTZv8mNIR3A+5YHv0lLIQ7k9HBAf4ZDOBqG
         VpE4riN5KHkiMsoYQc0FL6v72DOhd4CYgE8iirAPYsdo2JO1aXk0CM6VmSNjf8B98vFB
         d1wQ==
X-Gm-Message-State: AOAM532vRBMB5nm1BoX2ZqRMz4FWz2YooGqpWzS+Cd3IfZBTWF+3bEXz
        8aogewZiWPe/7zBb1OEHMHNHMKa/x52UTBMaZr0v/yAV0bN44fvQNtxrUKdJoIrhTRfGfS3R5le
        qa38j80tf93HDhut6Xrj+vLLv
X-Received: by 2002:a37:40d2:: with SMTP id n201mr11379967qka.287.1613769256411;
        Fri, 19 Feb 2021 13:14:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbodzFZyQN8nD+5Bv9iM7n2ksdk2GmMPOXXn65rtO9bRFBynvgjG56MCH9CX8Bne5kBB5QcQ==
X-Received: by 2002:a37:40d2:: with SMTP id n201mr11379951qka.287.1613769256237;
        Fri, 19 Feb 2021 13:14:16 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id g20sm6253331qtq.35.2021.02.19.13.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:14:15 -0800 (PST)
Message-ID: <1755ae053e78a1f0eea1789f84e6206777eb46ac.camel@redhat.com>
Subject: Re: [Intel-gfx] [RFC v4 10/11] drm/dp: Extract i915's eDP backlight
 code into DRM helpers
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, greg.depoire@gmail.com,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>
Date:   Fri, 19 Feb 2021 16:14:14 -0500
In-Reply-To: <YC6IZ+BUcA5uDCej@intel.com>
References: <20210208233902.1289693-1-lyude@redhat.com>
         <20210208233902.1289693-11-lyude@redhat.com>
         <20210211041540.GI82362@intel.com>
         <355ce12ec69a9b5f20b4a856a40c8abf413be5c0.camel@redhat.com>
         <87mtw1ai4m.fsf@intel.com> <YC6IZ+BUcA5uDCej@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-02-18 at 17:31 +0200, Ville Syrjälä wrote:
> On Thu, Feb 18, 2021 at 10:35:05AM +0200, Jani Nikula wrote:
> > On Fri, 12 Feb 2021, Lyude Paul <lyude@redhat.com> wrote:
> > > I think it wouldn't be a bad idea to just address this with a followup
> > > series
> > > instead and use the old DRM_DEBUG_* macros in the mean time.
> > 
> > aux->dev is there, could also use dev_dbg et al. in the mean time. They
> > handle NULL dev gracefully too if the driver didn't set that.
> 
> Last I looked aux->dev was random. Some drivers point it at the
> connector vs. some at the the pci/platform device.
> 

That's correct-for most SoCs the AUX channel is actually a standalone platform
device that isn't associated with the DRM device by default. /But/ I went
through the tree yesterday and the day before and did a bunch of cleanup around
DP aux registration, added a drm_dev field and hooked it up in every driver with
an aux channel, and then converted all of the DP helpers (including dual mode
and MST) over to using drm_dbg_*() variants. Once I've gotten through reading
all my email for today I'm going to do a quick sanity check on it and then post
the series to dri-devel.

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

