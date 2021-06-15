Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD6A3A8B41
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFOVld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOVla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:41:30 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7715FC061574;
        Tue, 15 Jun 2021 14:39:24 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso351740oto.12;
        Tue, 15 Jun 2021 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJeNxFDQW25gUsK+axdOU+LMUM5LMZyIj86MUl84e4o=;
        b=LF9+53iLy5sIQQbAlN5ihLtgqVVizux4dTWIzZsojk0Nx9QHrRudxCO97EuYzZjmUm
         Cx6Wo1fFrj5NnHJZF6DvO445tUX69PJjSCrKgXdXtV5BsFz1myDjGnjMzllrD/PjyOKr
         k1xO71/Y0nHyMcdfe8qbuP6x34wHrKToA4ajt9Ed8UPsZQonN9kyz75jQeCAxX8N1ogl
         QBS+8IIF4rtlNxiSiHzCAQQkk/wEPOfEju9LnwX2PAfGnee7yfcqzk7hCuEZ0O/TNzSQ
         N7Cp0DNGueDEoKrAwwnX1qfhb+Giy8SYudlvzZeA3A5sTjUktyjIpCxyz4uCh6G2Cgza
         tO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zJeNxFDQW25gUsK+axdOU+LMUM5LMZyIj86MUl84e4o=;
        b=EQqAxrVLGfs+wlpqzIi0g0uSqFGNljphPkQgxOg7AoumBzgSNhJymVIjTG9iDI6lMH
         LKxGiUwtTaY0yoyQhuWXo1Tt4G3qZxS0+pjgEO9Z5znusgOaiRc3kwCK97aYOu4muNe+
         Dqd5MgBBZ9nGcdaanufEMdoRPPuHXNZczXUmjVmxJgMo6b+m4vM0zsnhnyHyQXMNpqRe
         VP6v4CvTBRNVr0CJOf+m3AyFqOC1NSfmLchRQ4lohkJgIDSrcZSoHIoqRLKQJsqw6faq
         fvl+XuinUba8Isdpu+ShkbEMesymHrgh67kyIb3oHOIbDoxZTJ9nDSbtJOKJA3irCCFy
         DJEQ==
X-Gm-Message-State: AOAM531dGm3rTwGCBTsqHQItu4NqC3VoZz+Q33jClgC02Eji2yeHaCKq
        3hlhv4OpUdmMLY8+tksBVR8=
X-Google-Smtp-Source: ABdhPJzUUGSVi2YGb+x/x24cOVxZntHkPmmPjkN6cZx8tCXFSM/c4sQXMyvw655S6Lo3/5qPtKaCbA==
X-Received: by 2002:a9d:6c91:: with SMTP id c17mr1084102otr.48.1623793163861;
        Tue, 15 Jun 2021 14:39:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 16sm41638otm.57.2021.06.15.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:39:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Jun 2021 14:39:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Ignore Vsafe0v in
 PR_SWAP_SNK_SRC_SOURCE_ON state
Message-ID: <20210615213920.GA969448@roeck-us.net>
References: <20210615173206.1646477-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615173206.1646477-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 01:32:06AM +0800, Kyle Tso wrote:
> In PR_SWAP_SNK_SRC_SOURCE_ON state, Vsafe0v is expected as well so do
> nothing here to avoid state machine going into SNK_UNATTACHED.
> 
> Fixes: 28b43d3d746b ("usb: typec: tcpm: Introduce vsafe0v for vbus")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 197556038ba4..e11e9227107d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5212,6 +5212,7 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
>  		}
>  		break;
>  	case PR_SWAP_SNK_SRC_SINK_OFF:
> +	case PR_SWAP_SNK_SRC_SOURCE_ON:
>  		/* Do nothing, vsafe0v is expected during transition */
>  		break;
>  	default:
> -- 
> 2.32.0.272.g935e593368-goog
> 
