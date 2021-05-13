Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410A437FB81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhEMQbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229687AbhEMQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620923424;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKlAqAzAdOkwZ6eIbNgye1aUEknPcQRsjC+5Imsws/M=;
        b=Y7ox9ftxwJDs7xO21+1g3qgI4CsHsJrRFPBpnpCPzdS6yKyg2D+1+ePW1Vw5sIIul5NVYn
        GOOUhwn2fzE96lmQOTWIwLoM5luHx/9apRZDDvYpoI5Iw8nK1yimFmH+qYHJIVYXCPBTNL
        aRxAovANqSWfo0fbMgH8zVIRHJGNWIg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-Yr96cMOXPva8WoxEDvPZhg-1; Thu, 13 May 2021 12:30:20 -0400
X-MC-Unique: Yr96cMOXPva8WoxEDvPZhg-1
Received: by mail-qv1-f72.google.com with SMTP id l61-20020a0c84430000b02901a9a7e363edso21682963qva.16
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=UKlAqAzAdOkwZ6eIbNgye1aUEknPcQRsjC+5Imsws/M=;
        b=oYWWN1PReXyGhn/X2THKUdg7u37Efvegw9YuVQDB2mNvNSlvTJFBZy+5kYsHhgo164
         4auM8CR0Ous/1aRkoVwMqZTYqRa2Twrmn3BPPGQy6JOSl9RYkGxHBc9UNGAzi/pqran2
         /Vy7dIsSkaHawlmtSiYF+c3eyD+4mMOYD/274+y+/rXz+7lrBQYAwkch6/0KPwVwjVqo
         Bp5dDL+FNBzljVbScQJ6Bqa1Q4KY7gPnSRja+J0NjtZip4zO6Lytuo64RCk2qkWd1S0p
         0F5QE30UgEr2mTN8Vfki00PyLxXtjnfZipH7YqO87NICwMMsTtwo7DlbudAKxSi/UW7n
         Vezg==
X-Gm-Message-State: AOAM532RhBn9i83gwjFjiknFytUGmjNI+1GxnKs2Wyay0y2lwuJZq6tf
        SXSHzoywyfDwxMKODN9aFSY35MtFxQG/hUKzlZ3WjHlpKeDmUeiRhqJuKB64JiZzsG8T9nTmWWn
        1u55fiiAAPCjB3JpnPBBXjwDs
X-Received: by 2002:a0c:9ccc:: with SMTP id j12mr41602842qvf.30.1620923420234;
        Thu, 13 May 2021 09:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc8Rq7U8MaE0HbKTFcONDAmCUSSaFRW+dRCnQLvlk0JlSL147U1Csh03bv70NI7Z+obYiZjg==
X-Received: by 2002:a0c:9ccc:: with SMTP id j12mr41602812qvf.30.1620923420002;
        Thu, 13 May 2021 09:30:20 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id d74sm2764737qkc.87.2021.05.13.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 09:30:19 -0700 (PDT)
Message-ID: <4cf27d40eb44caaee37792e5d35296cf70109702.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] drm/dp_mst: Use kHz as link rate units when
 settig source max link caps at init
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Nikola Cornij <nikola.cornij@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>, Chris Park <Chris.Park@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Imre Deak <imre.deak@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        James Jones <jajones@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>
Date:   Thu, 13 May 2021 12:30:17 -0400
In-Reply-To: <20210512210011.8425-2-nikola.cornij@amd.com>
References: <20210512210011.8425-1-nikola.cornij@amd.com>
         <20210512210011.8425-2-nikola.cornij@amd.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will let this sit on the list for a few days to see if anyone's got any
objections and then I'll go ahead and push it

On Wed, 2021-05-12 at 17:00 -0400, Nikola Cornij wrote:
> [why]
> Link rate in kHz is what is eventually required to calculate the link
> bandwidth, which makes kHz a more generic unit. This should also make
> forward-compatibility with new DP standards easier.
> 
> [how]
> - Replace 'link rate DPCD code' with 'link rate in kHz' when used with
> drm_dp_mst_topology_mgr_init()
> - Add/remove related DPCD code conversion from/to kHz where applicable
> 
> Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 4 ++--
>  drivers/gpu/drm/drm_dp_mst_topology.c                     | 8 ++++----
>  drivers/gpu/drm/i915/display/intel_dp_mst.c               | 4 ++--
>  drivers/gpu/drm/nouveau/dispnv50/disp.c                   | 5 +++--
>  drivers/gpu/drm/radeon/radeon_dp_mst.c                    | 2 +-
>  include/drm/drm_dp_mst_helper.h                           | 8 ++++----
>  6 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 4a0c24ce5f7d..f78dd021f591 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -458,8 +458,8 @@ void amdgpu_dm_initialize_dp_connector(struct
> amdgpu_display_manager *dm,
>                 &aconnector->dm_dp_aux.aux,
>                 16,
>                 4,
> -               (u8)max_link_enc_cap.lane_count,
> -               (u8)max_link_enc_cap.link_rate,
> +               max_link_enc_cap.lane_count,
> +               drm_dp_bw_code_to_link_rate(max_link_enc_cap.link_rate),
>                 aconnector->connector_id);
>  
>         drm_connector_attach_dp_subconnector_property(&aconnector->base);
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 54604633e65c..32b7f8983b94 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3722,9 +3722,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> drm_dp_mst_topology_mgr *mgr, bool ms
>                 }
>  
>                 lane_count = min_t(int, mgr->dpcd[2] & DP_MAX_LANE_COUNT_MASK,
> mgr->max_lane_count);
> -               link_rate = min_t(int, mgr->dpcd[1], mgr->max_link_rate);
> +               link_rate = min_t(int, drm_dp_bw_code_to_link_rate(mgr-
> >dpcd[1]), mgr->max_link_rate);
>                 mgr->pbn_div = drm_dp_get_vc_payload_bw(mgr,
> -
>                                                        drm_dp_bw_code_to_link_r
> ate(link_rate),
> +                                                       link_rate,
>                                                         lane_count);
>                 if (mgr->pbn_div == 0) {
>                         ret = -EINVAL;
> @@ -5454,7 +5454,7 @@ EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
>   * @max_dpcd_transaction_bytes: hw specific DPCD transaction limit
>   * @max_payloads: maximum number of payloads this GPU can source
>   * @max_lane_count: maximum number of lanes this GPU supports
> - * @max_link_rate: maximum link rate this GPU supports, units as in DPCD
> + * @max_link_rate: maximum link rate per lane this GPU supports in kHz
>   * @conn_base_id: the connector object ID the MST device is connected to.
>   *
>   * Return 0 for success, or negative error code on failure
> @@ -5462,7 +5462,7 @@ EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
>  int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>                                  struct drm_device *dev, struct drm_dp_aux
> *aux,
>                                  int max_dpcd_transaction_bytes, int
> max_payloads,
> -                                u8 max_lane_count, u8 max_link_rate,
> +                                int max_lane_count, int max_link_rate,
>                                  int conn_base_id)
>  {
>         struct drm_dp_mst_topology_state *mst_state;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index f608c0cb98f4..26f65445bc8a 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -960,8 +960,8 @@ intel_dp_mst_encoder_init(struct intel_digital_port
> *dig_port, int conn_base_id)
>         intel_dp_create_fake_mst_encoders(dig_port);
>         ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, &i915->drm,
>                                            &intel_dp->aux, 16, 3,
> -                                          (u8)dig_port->max_lanes,
> -                                         
> drm_dp_link_rate_to_bw_code(max_source_rate),
> +                                          dig_port->max_lanes,
> +                                          max_source_rate,
>                                            conn_base_id);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index c46d0374b6e6..f949767698fc 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1617,8 +1617,9 @@ nv50_mstm_new(struct nouveau_encoder *outp, struct
> drm_dp_aux *aux, int aux_max,
>         mstm->mgr.cbs = &nv50_mstm;
>  
>         ret = drm_dp_mst_topology_mgr_init(&mstm->mgr, dev, aux, aux_max,
> -                                          (u8)max_payloads, outp->dcb-
> >dpconf.link_nr,
> -                                          (u8)outp->dcb->dpconf.link_bw,
> conn_base_id);
> +                                          max_payloads, outp->dcb-
> >dpconf.link_nr,
> +                                          drm_dp_bw_code_to_link_rate(outp-
> >dcb->dpconf.link_bw),
> +                                          conn_base_id);
>         if (ret)
>                 return ret;
>  
> diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c
> b/drivers/gpu/drm/radeon/radeon_dp_mst.c
> index 13072c2a6502..ec867fa880a4 100644
> --- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
> +++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
> @@ -642,7 +642,7 @@ radeon_dp_mst_init(struct radeon_connector
> *radeon_connector)
>         radeon_connector->mst_mgr.cbs = &mst_cbs;
>         return drm_dp_mst_topology_mgr_init(&radeon_connector->mst_mgr, dev,
>                                             &radeon_connector->ddc_bus->aux,
> 16, 6,
> -                                           4, (u8)max_link_rate,
> +                                           4,
> drm_dp_bw_code_to_link_rate(max_link_rate),
>                                             radeon_connector->base.base.id);
>  }
>  
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index c87a829b6498..ddb9231d0309 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -596,11 +596,11 @@ struct drm_dp_mst_topology_mgr {
>         /**
>          * @max_lane_count: maximum number of lanes the GPU can drive.
>          */
> -       u8 max_lane_count;
> +       int max_lane_count;
>         /**
> -        * @max_link_rate: maximum link rate per lane GPU can output.
> +        * @max_link_rate: maximum link rate per lane GPU can output, in kHz.
>          */
> -       u8 max_link_rate;
> +       int max_link_rate;
>         /**
>          * @conn_base_id: DRM connector ID this mgr is connected to. Only used
>          * to build the MST connector path value.
> @@ -774,7 +774,7 @@ int drm_dp_mst_topology_mgr_init(struct
> drm_dp_mst_topology_mgr *mgr,
>                                  struct drm_device *dev, struct drm_dp_aux
> *aux,
>                                  int max_dpcd_transaction_bytes,
>                                  int max_payloads,
> -                                u8 max_lane_count, u8 max_link_rate,
> +                                int max_lane_count, int max_link_rate,
>                                  int conn_base_id);
>  
>  void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr);

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

