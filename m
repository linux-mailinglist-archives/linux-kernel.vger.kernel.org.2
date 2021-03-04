Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E359E32D4E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhCDOFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237358AbhCDOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614866628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDQP6snMag6XxAEBa+EmQwWRFCxkjx4xBBCVCl5Gh1A=;
        b=YgGaCTVkRaVUSz6hA+cPm+arzqiIJ2QJeX8zYvZSC/lgNlpsCJh3ISYGNNoIBQ0T92dWre
        rUlxrAd16GYDspbpqbf8oU0LYEvpgPPNd/Nd3GY+GsDYXHToH4Q4j5UK1DXFs+706r1xdQ
        0bviPl+8gzRkhpzbaburhREBKr4kfqA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-GAEDJeamP0SffiX6NF1NbA-1; Thu, 04 Mar 2021 09:03:47 -0500
X-MC-Unique: GAEDJeamP0SffiX6NF1NbA-1
Received: by mail-ed1-f69.google.com with SMTP id v27so7133067edx.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vDQP6snMag6XxAEBa+EmQwWRFCxkjx4xBBCVCl5Gh1A=;
        b=BgDf6IX0BHgnKit3jhcXX7j6SOIu6Il36DVoBSU1JPwY6w2CEeClZYoDxfrADaCDsd
         TbJLOit/k2t8Y9UIBVCJcpNJ8JMwZ431yiKqKhTUaQK0JDq/qNLB1ufwRUVVBSrWYxBB
         tjnzqaKa+aZImMfc8euIRkuCY1TSNx6+V7BMpfQ2/S4IhEXhguZoZFhkejbXi4FjUzQ0
         vAUjAk0HDVCAFWeySPWTFfUrDe9tzoMo4PpwyLA3/Wopv1uWJG9QCzDaiSdiQRnE6WDe
         ZF4pHloinE+eXAzgNuJ2R7mI3tPUK4IDMbQkl0eoeBi4yrB2ilOF+VtqPyq48LdusAPm
         lrGQ==
X-Gm-Message-State: AOAM530YiF8YF7CEZG2uWHhzw74ADdsveArb8QFOQa5XqiPuzloPGzcW
        NCyoFmsyJuDM0assHYulOGeLSISYxEirGURlbvxLAPXSaD7wTKvSm2u6H07dnzSPDNNkXhMDh3y
        rAOtrswjx2F2Qep0L8KJ1klX0
X-Received: by 2002:a17:906:3801:: with SMTP id v1mr4428855ejc.353.1614866624789;
        Thu, 04 Mar 2021 06:03:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZplifH1rsPnLSh/UDJJZohAnMagDJLqjaHg1OVrs9ysOY30ZNvytm6Kup6F2ILxmyAQp2KQ==
X-Received: by 2002:a17:906:3801:: with SMTP id v1mr4428837ejc.353.1614866624612;
        Thu, 04 Mar 2021 06:03:44 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id jx22sm22114314ejc.105.2021.03.04.06.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 06:03:43 -0800 (PST)
Subject: Re: [PATCH 1/4] platform/x86: simatic-ipc: add main driver for
 Siemens devices
To:     Henning Schild <henning.schild@siemens.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20210302163309.25528-1-henning.schild@siemens.com>
 <20210302163309.25528-2-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ed715381-016a-5bf7-3cdb-d340747c4498@redhat.com>
Date:   Thu, 4 Mar 2021 15:03:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210302163309.25528-2-henning.schild@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/2/21 5:33 PM, Henning Schild wrote:

<snip>

> +static inline u32 simatic_ipc_get_station_id(u8 *data)
> +{
> +	u32 station_id = SIMATIC_IPC_INVALID_STATION_ID;
> +	int i;
> +	struct {
> +		u8	type;		/* type (0xff = binary) */
> +		u8	len;		/* len of data entry */
> +		u8	reserved[3];
> +		u32	station_id;	/* station id (LE) */
> +	} __packed * data_entry = (void *)data;
> +
> +	/* find 4th entry in OEM data */
> +	for (i = 0; i < 3; i++)
> +		data_entry = (void *)((u8 *)(data_entry) + data_entry->len);
> +
> +	/* decode station id */
> +	if (data_entry && data_entry->type == 0xff && data_entry->len == 9)
> +		station_id = le32_to_cpu(data_entry->station_id);
> +
> +	return station_id;
> +}
> +
> +static inline void
> +simatic_ipc_find_dmi_entry_helper(const struct dmi_header *dh, void *_data)
> +{
> +	u32 *id = _data;
> +
> +	if (dh->type != DMI_ENTRY_OEM)
> +		return;
> +
> +	*id = simatic_ipc_get_station_id((u8 *)dh + sizeof(struct dmi_header));
> +}

Please take dh->length into account here and make sure that you don't walk
past the end of the DMI tables during the parsing here.

Regards,

Hans


> +
> +#endif /* __PLATFORM_DATA_X86_SIMATIC_IPC_H */
> 

