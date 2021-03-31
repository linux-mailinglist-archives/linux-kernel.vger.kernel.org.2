Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E55A3509A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhCaVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:39:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:39566 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232839AbhCaVje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:39:34 -0400
IronPort-SDR: gZ9XVsZXd9La1n1EXzzdIG6NrPT3b7bChE3fLuT7hjYi/DYJ9ML77XPmYBQvrHzH7SvLKRPGBS
 Ldf3+DFIKBfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="253432727"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="253432727"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:39:33 -0700
IronPort-SDR: rg4vCFY7u575fL2/Uo0K4u5OtieTpCfP9y1Zo+P5cVPLG4UAfn3kBGG46Wi/r3BzFSX10y9mPA
 Cw2ey0c08nGA==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="377433387"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.177.63]) ([10.212.177.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:39:33 -0700
Subject: Re: [PATCH v2 10/24] x86/resctrl: Swizzle rdt_resource and
 resctrl_schema in pseudo_lock_region
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20210312175849.8327-1-james.morse@arm.com>
 <20210312175849.8327-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <087b646a-91b6-d333-830d-4d040be2fd24@intel.com>
Date:   Wed, 31 Mar 2021 14:39:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210312175849.8327-11-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/12/2021 9:58 AM, James Morse wrote:
> struct pseudo_lock_region points to the rdt_resource. Once the
> resources are merged, this won't be unique. The resource name
> is moving into the scheam, so that eventually resctrl can generate

s/scheam/schema/?

Reinette
