Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0403A8848
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhFOSLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:11:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:37470 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhFOSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:11:05 -0400
IronPort-SDR: t74feb/Gj0GQrzLNPEOeTi3uzZ2ulkf0M+0WSpH2ViEGnx9Cr4MCQ4JVSA8rECnCFsqFbe9pPv
 9arewqD6YZLg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="269894378"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="269894378"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:08:47 -0700
IronPort-SDR: Yo9ghuhg3O2X9tE9lFN6/bEB8QzvNC5ncG+Pl/rvU1Cc6CR/5qRu7quEJGE5wpUdPq0msTFj1Q
 7qn4MT+jSStw==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554528746"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:08:46 -0700
Subject: Re: [PATCH v4 11/24] x86/resctrl: Move the schemata names into struct
 resctrl_schema
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
 <20210614200941.12383-12-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <fd6ab3a6-c02c-fbdb-3a9a-b0469e8003ef@intel.com>
Date:   Tue, 15 Jun 2021 11:08:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614200941.12383-12-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/14/2021 1:09 PM, James Morse wrote:
> resctrl 'info' directories and schema parsing use the schema name.
> This lives in the struct rdt_resource, and is specified by the
> architecture code.
> 
> Once the CDP resources are merged, there will only be one resource
> (and one name) in use by two schema. To allow the CDP CODE/DATA
> property to be the tyoe of configuration the schema uses, the

tyoe -> type

Reinette
