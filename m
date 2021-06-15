Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB933A8849
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhFOSLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:11:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:8538 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhFOSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:11:05 -0400
IronPort-SDR: UNpnCLGQANDcr/qCbw85QUSYuDFZQQdMuDYPAJG/MiS4hglw4sAr+Y8L05i8+jzJmhdLC0G/Mc
 SyFJv6iXeqVA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204214820"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="204214820"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:09:00 -0700
IronPort-SDR: 5iTgW6+ws4jEnyNlU3RUF9nhigIOUYsUmFXk+4X6oPHLKj73muhySis6uWczgCr7QgyyuJcV4k
 QqL8jq5zxsag==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554528822"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:08:59 -0700
Subject: Re: [PATCH v4 12/24] x86/resctrl: Group staged configuration into a
 separate struct
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com
References: <20210614200941.12383-1-james.morse@arm.com>
 <20210614200941.12383-13-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <20699528-e26b-bc81-c8bd-af26ba14a9c3@intel.com>
Date:   Tue, 15 Jun 2021 11:08:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614200941.12383-13-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/14/2021 1:09 PM, James Morse wrote:
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8fa806c85cec..8fad1af8f15e 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -23,13 +23,21 @@ enum resctrl_conf_type {
>   	CDP_DATA,
>   };
>   
> +/**
> + * struct resctrl_staged_config - parsed configuration to be applied
> + * @new_ctrl:		new ctrl value to be loaded
> + * @have_new_ctrl:	whether the user provide new_ctrl is valid

user provide -> user provided?

Reinette
