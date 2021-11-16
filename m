Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE67452DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhKPJWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhKPJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:22:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D7C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:19:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w29so36120797wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ZZ5qtct0gReM0veqtvP3uHFmenhhHdLVzBUtdLlNxJU=;
        b=FPNECisJWg97qsX6YuqXQNB6Sue6Q8Q39s5qXnIUbI3Eja1cgj9hQ43mt0XcwT84RZ
         /XyY55pV1CR2TGsc7y4hn/dQBfKRLT65HHQC1Xz4ivHmhciGyubG+03hAhL1mQbnsiPz
         cfT438ohx21BUz+300sEHdxvuHf2mpZDXb1thNNXEWP/5nvL/pLLlOsTmeQDlIiFyYnJ
         WWdjSFnyQn5k2kbH9cVRijX98C1mYbS8Ezbdpwhf/mH7uE5/Yjm96SUeXtFDpaG07gTp
         qZpSwAWJaumC4IbF9oJiCg8BH5ldgeSDLWVPRixnAUnVcb8+S1FGwoFqN1raXLkQ0SQl
         q3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZZ5qtct0gReM0veqtvP3uHFmenhhHdLVzBUtdLlNxJU=;
        b=O0oeQIafm/M5SInsHKSEScp4IH5zRiXihT+UrW1j96J85gkWIQMwJirZ1wJu1R3y+U
         GzV0XtlP6TB4r/O97GFqFURMeInNh0/PUqiWIspGI0e/imXjOHbZrkGgpWXJRoA0Npe5
         h1TgY/3TYE8P5C+2GvC2Gt1uHRX3pXaMl4C31qmpRXMNh1Z6P2dWJmjaPUtY8NOfo0Mb
         6g8KVchk4Dgtfw6TlG1E5GbbC2yEOfQHO6XgBnOLLHVpo+HbnJezgH+xN11Zu4JEunL+
         xGwyEzld0s1IGWubXqocp7SYGPDwnmaZMqm+bVocBUsFRGWUI7ZqzmBVPXA06pgjnBz7
         fOZg==
X-Gm-Message-State: AOAM530iuihOYXPS3wmH0loPWiK0aFIzXYbhP4JJQfhF/vrUXHIDD2Vy
        AV9vJ9ElMxA05CYK8F8W39QFanaoWsE=
X-Google-Smtp-Source: ABdhPJzsTNyvDWu3WC/2tAllTUTwz9jBCO6xvduzfNLLfGl+N3dtMqB+QzCsR0uBvvu5/P1TswIDKw==
X-Received: by 2002:adf:f787:: with SMTP id q7mr7461935wrp.1.1637054382983;
        Tue, 16 Nov 2021 01:19:42 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de. [87.176.183.123])
        by smtp.gmail.com with ESMTPSA id i15sm2043189wmq.18.2021.11.16.01.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:19:42 -0800 (PST)
Subject: Re: [PATCH] drm/amd/display: cleanup the code a bit
To:     Bernard Zhao <bernard@vivo.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211116013438.26517-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <88328288-ef1f-ef8b-987f-43dc8dc69ee7@gmail.com>
Date:   Tue, 16 Nov 2021 10:19:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116013438.26517-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.11.21 um 02:34 schrieb Bernard Zhao:
> In function dc_sink_destruct, kfree will check pointer, no need
> to check again.
> This change is to cleanup the code a bit.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

This one and the other patch are Acked-by: Christian König 
<christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_sink.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
> index a249a0e5edd0..4b5e4d8e7735 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
> @@ -33,14 +33,6 @@
>    * Private functions
>    ******************************************************************************/
>   
> -static void dc_sink_destruct(struct dc_sink *sink)
> -{
> -	if (sink->dc_container_id) {
> -		kfree(sink->dc_container_id);
> -		sink->dc_container_id = NULL;
> -	}
> -}
> -
>   static bool dc_sink_construct(struct dc_sink *sink, const struct dc_sink_init_data *init_params)
>   {
>   
> @@ -75,7 +67,7 @@ void dc_sink_retain(struct dc_sink *sink)
>   static void dc_sink_free(struct kref *kref)
>   {
>   	struct dc_sink *sink = container_of(kref, struct dc_sink, refcount);
> -	dc_sink_destruct(sink);
> +	kfree(sink->dc_container_id);
>   	kfree(sink);
>   }
>   

