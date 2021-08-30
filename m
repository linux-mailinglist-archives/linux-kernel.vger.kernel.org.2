Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8E3FB91C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhH3Pj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:39:28 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:39519 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbhH3Pj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:39:27 -0400
Received: by mail-ej1-f48.google.com with SMTP id a25so32036858ejv.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GvG3BPkL8GDwWI4NDLg3xm7QcfwfDFAgBHT+PFB/gGg=;
        b=gqkAUp23Lgb01d62FAbPFq7w5Q+2mA30V1j02NwJ0k9O+W3acZSuliYwFHa9X/gsYQ
         KerqqEEjiyqXeFiwwf7HQXFHQ6RYPL2OYiuZgdbep6KPAWSxTceERYw2e8ArPP0Q0LbF
         hyj1K+1IgAPfdUlHRc+znjXfYlAtOrmIL7WCRkDio84/GBC+HcOLlPwhv8g3MXWW0I9G
         N+ony8wBA8dbfBO+nVSBXm2iWDan8TQlWfFaXDMo9NRAAQOIJmyl6s5pwC43MzGBaiCz
         HW+MJZ/wk2frArSZjAgR/vzZIaWhYk6Y37VGLi+xwccmHNvwcvAqVBPjwFX5/3Nz14ZV
         wk6g==
X-Gm-Message-State: AOAM532dfkUY4/lPymaAtom3tBx7RGsdIgsdmNXKs3PsHAHUL8K8P0KR
        VjTrS9kHAuFKzIpNWi3puSw=
X-Google-Smtp-Source: ABdhPJyrm1XsokPNLWD+oHtckSQ0hd3ttotKOY58uBZuekNmj5lQ4O29XdqY/euXZd2Od/HXv6oJGQ==
X-Received: by 2002:a17:906:2c5a:: with SMTP id f26mr10450012ejh.205.1630337911554;
        Mon, 30 Aug 2021 08:38:31 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il. [109.186.228.184])
        by smtp.gmail.com with ESMTPSA id l18sm6000367edr.83.2021.08.30.08.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:38:31 -0700 (PDT)
Subject: Re: [PATCH v6] nvme-tcp: Do not reset transport on data digest errors
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        yi.he@emc.com, kernel test robot <lkp@intel.com>
References: <20210830133626.139828-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <462c31ae-446b-cc23-eb91-5e27ef04ec13@grimberg.me>
Date:   Mon, 30 Aug 2021 18:38:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830133626.139828-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -485,6 +486,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> +	struct nvme_tcp_request *req;
>   	struct request *rq;
>   
>   	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
> @@ -496,7 +498,11 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +	req = blk_mq_rq_to_pdu(rq);
> +	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))

endian conversion a zero enum? looks weird..

But,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
