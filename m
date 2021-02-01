Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A430B272
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhBAV76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:59:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhBAV74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612216709;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAv56oszImRnWuGI/mjFlmDAjkrJfHgnXQKipCrtRz4=;
        b=auj8So0BERLEJLeosxMVV5UgwLqCrKfryo2RM7UVXUEtJyDQ/aEcjsCVuDUP8nfVO0bk9u
        wpUPVvWLbFhlrCKSkPMbh3Z2vH07W7spbzNFw8xU+O9niwTVHe5vHn92HOHxKVlFJaDlNw
        RGgDnC5BzPKecAKwU07RN3FfyHbZXgA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-_v_4K5tpNMm00MTZM_Gc3Q-1; Mon, 01 Feb 2021 16:58:27 -0500
X-MC-Unique: _v_4K5tpNMm00MTZM_Gc3Q-1
Received: by mail-qt1-f200.google.com with SMTP id j14so11677320qtv.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=pAv56oszImRnWuGI/mjFlmDAjkrJfHgnXQKipCrtRz4=;
        b=KvRzg6a04oQ3HK44diqr3nNCTr5meJxXn3IEDVcytz90fgKqjh7yhoJrwezwJA5uoj
         6MDv3bRTmwhCg1WZwu+axVKQ+hX0AF+1lV2XJO+41vA7bZWd4AaXHnzUnRsIMU33UYOh
         0nKtig2+QAumdugnGxDI594fq5qChE88JpfNkmWxBVsuKLCBNwPx9jzglcwAGPXlT98q
         BP7SKrwzpezbjwAIczDh9W8KMj0Gc3kdeOH8hC66b61JWpSlxrSJSz1monTvsIymKfh+
         IawXmjZtST1WbxnXVQi5hHU+hG6YKFujCQkceuPyq/jv2wbcN/JaY1plcET5bKy3Ms1f
         uz6Q==
X-Gm-Message-State: AOAM5309iJDrFr/pYCWfGh7/JnQyvUJquZ/VqA+mNx/tgcwxGdNikSC3
        tenlU9UYPy+HcPizZndvoltvgf7puimzmw2hHWVTsoq8QtTkOfP/N8+oT/fshgv4FWliqftKX3M
        yWwxEqPS++r30XyFK2EvuOfgX
X-Received: by 2002:a0c:a819:: with SMTP id w25mr17274548qva.6.1612216706994;
        Mon, 01 Feb 2021 13:58:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGyF7f7x2RmxXI8G7IMQJG+Z8oD/nTW3p2NHQwvns5+ePaKwqtdiFtS+Qd9r3JMb4BC7MPEA==
X-Received: by 2002:a0c:a819:: with SMTP id w25mr17274539qva.6.1612216706848;
        Mon, 01 Feb 2021 13:58:26 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 186sm15487568qkh.30.2021.02.01.13.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:58:26 -0800 (PST)
Message-ID: <5f2e7207e5227bdeb3c8e8cf453757cfbb5a4344.camel@redhat.com>
Subject: Re: [PATCH v3 2/4] drm_dp_mst_topology: use correct AUX channel
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Sam McNally <sammc@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
Date:   Mon, 01 Feb 2021 16:58:25 -0500
In-Reply-To: <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
         <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
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
> For adapters behind an MST hub use the correct AUX channel.
> 
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> [sammc@chromium.org: rebased, removing redundant changes]
> Signed-off-by: Sam McNally <sammc@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/drm_dp_mst_topology.c | 36 +++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 15b6cc39a754..0d753201adbd 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2255,6 +2255,9 @@ drm_dp_mst_topology_unlink_port(struct
> drm_dp_mst_topology_mgr *mgr,
>         drm_dp_mst_topology_put_port(port);
>  }
>  
> +static ssize_t
> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
> +
>  static struct drm_dp_mst_port *
>  drm_dp_mst_add_port(struct drm_device *dev,
>                     struct drm_dp_mst_topology_mgr *mgr,
> @@ -2271,9 +2274,13 @@ drm_dp_mst_add_port(struct drm_device *dev,
>         port->port_num = port_number;
>         port->mgr = mgr;
>         port->aux.name = "DPMST";
> +       mutex_init(&port->aux.hw_mutex);
> +       mutex_init(&port->aux.cec.lock);

You're missing a matching mutex_destroy() for both of these

With that fixed:

Reviewed-by: Lyude Paul <lyude@redhat.com>

>         port->aux.dev = dev->dev;
>         port->aux.is_remote = true;
>  
> +       port->aux.transfer = drm_dp_mst_aux_transfer;
> +
>         /* initialize the MST downstream port's AUX crc work queue */
>         drm_dp_remote_aux_init(&port->aux);
>  
> @@ -3503,6 +3510,35 @@ static int drm_dp_send_up_ack_reply(struct
> drm_dp_mst_topology_mgr *mgr,
>         return 0;
>  }
>  
> +static ssize_t
> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
> +{
> +       struct drm_dp_mst_port *port =
> +               container_of(aux, struct drm_dp_mst_port, aux);
> +       int ret;
> +
> +       switch (msg->request & ~DP_AUX_I2C_MOT) {
> +       case DP_AUX_NATIVE_WRITE:
> +       case DP_AUX_I2C_WRITE:
> +       case DP_AUX_I2C_WRITE_STATUS_UPDATE:
> +               ret = drm_dp_send_dpcd_write(port->mgr, port, msg->address,
> +                                            msg->size, msg->buffer);
> +               break;
> +
> +       case DP_AUX_NATIVE_READ:
> +       case DP_AUX_I2C_READ:
> +               ret = drm_dp_send_dpcd_read(port->mgr, port, msg->address,
> +                                           msg->size, msg->buffer);
> +               break;
> +
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
>  {
>         if (dp_link_bw == 0 || dp_link_count == 0)

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

