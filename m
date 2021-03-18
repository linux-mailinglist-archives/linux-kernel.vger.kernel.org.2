Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974BF34106D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 23:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhCRWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 18:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230480AbhCRWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 18:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616107160;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGOHq/WbcE/FK7Ks4LiyUfXGKcEUtRkPJeBWF/9F28c=;
        b=IBXU5zNE5nVzGkztVFK1/Me2DrB5o0c9HDLmo9H2bT7/Pz8RbcfEaEEYWuOeMyWCTErS2b
        /QNtdqsjkoL98+yPqZa3Ilt2cF+GpqNPqGwv3/KKVkja9Q4HORq3VtG8VE2hIZWAkHUjta
        b4YjQB99PrESMmP556iim6nvwmbbwQw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-te0ZBAFUPDKE6sl4z3vN8w-1; Thu, 18 Mar 2021 18:39:18 -0400
X-MC-Unique: te0ZBAFUPDKE6sl4z3vN8w-1
Received: by mail-qv1-f71.google.com with SMTP id x20so21733633qvd.21
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 15:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=oGOHq/WbcE/FK7Ks4LiyUfXGKcEUtRkPJeBWF/9F28c=;
        b=gJH2MrKsvL0gHGlvDlrKkWrcOI7XT5hUnDnNG8h3rMKpKvBe3wHg2ZmM1zEvgIvD0C
         hL0E2JCk8OpTormYyireqp8m76mUYZKBTgP63Xo8vZisusGyPnI7ZWOhG+IlG7ABl/T7
         NUYGmrTQPiGEm2K2Sl+UTn11DTSk5v73xBCozqXCEZI+UMgcxC/iooBepMRpuCDWGReC
         SQmu4gREMtBP6iP3QBbiwzbhxjEcizsHTleH9kxUp/jxzg1MpfXQTUqDXa58zC4nyPZH
         opQXD39zWxybzUMJbQ2CjwAmKUG0ngd6AnaCADG7HQrAhXBkeYFDSXPw5c8CpsOXzi5B
         VqyA==
X-Gm-Message-State: AOAM532Vpx79x5BoEuKlFek4jMArkNTfAVYA4J6EEn+QiS2J/hph5gCz
        1FlFbIsnBQmF7XkBANbQ5Gpb0J9mHACTlH9xp3O0nik3ZeLk/V2Q7tbYPGV41lF52gSYvI+BU5C
        zPLB8hR57Yequ31C0qwDnuIXo
X-Received: by 2002:a37:ef18:: with SMTP id j24mr6906144qkk.96.1616107158223;
        Thu, 18 Mar 2021 15:39:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydzeTIFW5JZKSCJS0r2r5PeTzveIrvq8RZJWfkRgUk7Sjwyc7/hRalxGMlgbxkBUXrdV+tHQ==
X-Received: by 2002:a37:ef18:: with SMTP id j24mr6906125qkk.96.1616107157990;
        Thu, 18 Mar 2021 15:39:17 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id g11sm2961582qkk.5.2021.03.18.15.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 15:39:17 -0700 (PDT)
Message-ID: <e26fac2f5750f4bd606cdbf9def82a3ee31db71c.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms/nv50-: Check plane size for
 cursors, not fb size
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Peres <martin.peres@mupuf.org>
Date:   Thu, 18 Mar 2021 18:39:16 -0400
In-Reply-To: <CAKb7UviTpAva-kc4-=1oCV_CxHJrZE7mWec0rNrgQ4r-RG8e7w@mail.gmail.com>
References: <20210318215545.901756-1-lyude@redhat.com>
         <CAKb7UviTpAva-kc4-=1oCV_CxHJrZE7mWec0rNrgQ4r-RG8e7w@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-03-18 at 18:13 -0400, Ilia Mirkin wrote:
> On Thu, Mar 18, 2021 at 5:56 PM Lyude Paul <lyude@redhat.com> wrote:
> > 
> > Found this while trying to make some changes to the kms_cursor_crc test.
> > curs507a_acquire checks that the width and height of the cursor framebuffer
> > are equal (asyw->image.{w,h}). This is actually wrong though, as we only
> > want to be concerned that the actual width/height of the plane are the
> > same. It's fine if we scan out from an fb that's slightly larger than the
> > cursor plane (in fact, some igt tests actually do this).
> 
> How so? The scanout engine expects the data to be packed. Height can
> be larger, but width has to match.

Huh - wasn't expecting that, nice catch. I'll fix this up in a moment

> 
>   -ilia
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

