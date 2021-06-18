Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417C3AD3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhFRUjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:39:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:40466 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233702AbhFRUjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:39:19 -0400
IronPort-SDR: KOKr1pCYd6Ok4WMSDDG9D83H9i11LwOb9Tsy+d/dF4U399fAnY4TapncIFNb/vrhwOpeWdkEwm
 BFI5KJZ41Tag==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206658220"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="206658220"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 13:37:09 -0700
IronPort-SDR: 3AkLfnkZ8KxBn/rjNDGUd9DTtojx7p7i/6Xa0PuH8GQ42RtupwJpX2mhtGnVZPHbmOsFCUrg9a
 DIZlBF3nomxg==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="485816476"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.236.226]) ([10.212.236.226])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 13:37:08 -0700
Subject: Re: [PATCH v3] x86/resctrl: Fix kernel-doc in internal.h
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210616184330.13301-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <9100bce9-d27f-23e7-f5b5-2a6468a6b3bd@intel.com>
Date:   Fri, 18 Jun 2021 13:37:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616184330.13301-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/16/2021 11:43 AM, Fabio M. De Francesco wrote:
> @@ -78,10 +79,13 @@ struct mon_evt {
>   };
>   
>   /**
> - * struct mon_data_bits - Monitoring details for each event file
> - * @rid:               Resource id associated with the event file.
> + * union mon_data_bits - Monitoring details for each event file
> + * @priv:	       Used to store monitoring event data in @u
> + *		       as kernfs private data
> + * @rid:               Resource id associated with the event file
>    * @evtid:             Event id associated with the event file
>    * @domid:             The domain to which the event file belongs
> + * @u:		       Name of the bit fields struct
>    */
>   union mon_data_bits {
>   	void *priv;

This hunk continues to be whitespace broken. You are adding tabs when 
existing comments use spaces. Please ensure that your changes fit with 
the current style in this area.

Reinette
