Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4030B283
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBAWE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230050AbhBAWE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612216979;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uesdFeV6nckloOu0OQR9RdXWao3qQEYo5FYIRPhkjlE=;
        b=KR9Y//789m9AQP769g5FdNXK40n5ssmB91remBnqGSdT2OAyzGgXTShGpms+EVuggV+Uzp
        PNvc6wljB5pvhJ2wIUZ0F1fLshgKVvD2wyHnoDnvOgFUS1pVFb6Yu3OdiFkg11J41bLF9t
        teqjuUeqkrEUmB8RbRHz8kDCRTEcVzM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-hcrXRIFaOzqsdyNw9-TfCQ-1; Mon, 01 Feb 2021 17:02:57 -0500
X-MC-Unique: hcrXRIFaOzqsdyNw9-TfCQ-1
Received: by mail-qv1-f72.google.com with SMTP id e17so12326817qvo.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 14:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=uesdFeV6nckloOu0OQR9RdXWao3qQEYo5FYIRPhkjlE=;
        b=uoTBj4ZGTxKSNakc6XnKifUvRiAd95w7Dk2a07NK4R4zfU6pfWk5WYfKAwQcQ9W7w+
         tIK0JRzinNlFRWwj82ui2jAU0lJqgSdDPF3iE0PgRRGpUu0M8qVGiLYiJEOc9SIxOps8
         Ie4EFVybK84cmXVZZdgF2+cyXvzcS37rpKu5IdYvxLPZLp04Mgl4fNnEsHe35YHDAzwG
         uOUrV7fOy4FGQFyEQjbfvldZZbMr0UR1WpNJZwXGhh83YexwwaT8FWFxb2naC5NrEFHe
         q8P+7+oPAy5kWC08oRVYOOGghC9xntk3/5LamnJCYoPILypoE/rXYW8/40aenL0RdFql
         JxCw==
X-Gm-Message-State: AOAM533A1SbFkI9Rhcsr1/m4WatWG/vZNFdrxzNruf1sRGb/Tiy1SKph
        Wl/JS1bGXCtem+YYXkWV/GPkO0TpvWvfXcdsSEnooz08dgOFJkAr5YFqfeO4AuZyvMRrvg3glyg
        RJF+maeKD41DH6HpKTZkVE1dd
X-Received: by 2002:a05:6214:b2c:: with SMTP id w12mr17340608qvj.54.1612216976678;
        Mon, 01 Feb 2021 14:02:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzhKAQ22FHQtYQZXUUQ8oLzHZz+Wt78eyKQdBKRM4/o3r0mMg0+7/qj9XrmuIRIkXX8485Mg==
X-Received: by 2002:a05:6214:b2c:: with SMTP id w12mr17340595qvj.54.1612216976501;
        Mon, 01 Feb 2021 14:02:56 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id h144sm1676401qke.95.2021.02.01.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:55 -0800 (PST)
Message-ID: <a4a9ec24a6d4a646e22fb5c63e285d4d1bb50a0d.camel@redhat.com>
Subject: Re: [PATCH v3 3/4] drm_dp_mst_topology: export two functions
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Sam McNally <sammc@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
Date:   Mon, 01 Feb 2021 17:02:55 -0500
In-Reply-To: <20200923121320.v3.3.I6c917ff82a1d2ae2253a3bd4d750d58879387cac@changeid>
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
         <20200923121320.v3.3.I6c917ff82a1d2ae2253a3bd4d750d58879387cac@changeid>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-23 at 12:13 +1000, Sam McNally wrote:
> From: Hans Verkuil <hans.verkuil@cisco.com>
> 
> These are required for the CEC MST support.
> 
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> Signed-off-by: Sam McNally <sammc@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/drm_dp_mst_topology.c | 6 ++----
>  include/drm/drm_dp_mst_helper.h       | 4 ++++
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 0d753201adbd..c783a2a1c114 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -62,8 +62,6 @@ struct drm_dp_pending_up_req {
>  static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
>                                   char *buf);
>  
> -static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
> -
>  static int drm_dp_dpcd_write_payload(struct drm_dp_mst_topology_mgr *mgr,
>                                      int id,
>                                      struct drm_dp_payload *payload);
> @@ -1864,7 +1862,7 @@ static void drm_dp_mst_topology_get_port(struct
> drm_dp_mst_port *port)
>   * drm_dp_mst_topology_try_get_port()
>   * drm_dp_mst_topology_get_port()
>   */
> -static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
> +void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)

Mhhhhhh-can you think of some way around this? I really don't think it's a good
idea for us to be exposing topology references to things as-is, the thing is
they're really meant to be used for critical sections in code where it'd become
very painful to deal with an mst port disappearing from under us. Outside of MST
helpers, everyone else should be dealing with the expectation that these things
can disappear as a result of hotplugs at any moment.

Note that we do expose malloc refs, but that's intentional as holding a malloc
ref to something doesn't cause it to stay around even when it's unplugged - it
just stops it from being unallocated.


>  {
>         topology_ref_history_lock(port->mgr);
>  
> @@ -1935,7 +1933,7 @@ drm_dp_mst_topology_get_port_validated_locked(struct
> drm_dp_mst_branch *mstb,
>         return NULL;
>  }
>  
> -static struct drm_dp_mst_port *
> +struct drm_dp_mst_port *
>  drm_dp_mst_topology_get_port_validated(struct drm_dp_mst_topology_mgr *mgr,
>                                        struct drm_dp_mst_port *port)
>  {
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index c7c79e0ced18..d036222e0d64 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -754,6 +754,10 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
>                        struct drm_dp_mst_topology_mgr *mgr,
>                        struct drm_dp_mst_port *port);
>  
> +struct drm_dp_mst_port *drm_dp_mst_topology_get_port_validated
> +(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
> +void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
> +
>  struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct
> drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
>  
>  

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

