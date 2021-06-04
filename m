Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8234C39C420
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhFDX6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:58:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:9923 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhFDX6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:58:16 -0400
IronPort-SDR: Sw+QXhX4rWTvZL7uDeEB9OoInnxbe51juBsBYPSoAzFPBtss6GWUn5TXR0SemhWOnQg2w+WF37
 oopys/ZrIfIg==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="184072838"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="184072838"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 16:56:29 -0700
IronPort-SDR: XmqTVaH4Ad/m3xiRkL2D8xzEzGUV5Adk8iu5LT5Vi7xiLmoG8zU5o73h8ZTsnFhQ23mYtI063T
 Tf7CWmkTiPWg==
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="401112867"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.209.38.99]) ([10.209.38.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 16:56:29 -0700
Subject: Re: [PATCH v3 00/24] x86/resctrl: Merge the CDP resources
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
References: <20210519162424.27654-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <5900da79-b21e-e41c-6348-d9b24cf65967@intel.com>
Date:   Fri, 4 Jun 2021 16:56:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210519162424.27654-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/19/2021 9:24 AM, James Morse wrote:
> Hi folks,
> 
> Thanks to Reinette comments on v2. The major changes in v3 is a juggling
> of all the commit messages. One patch got merged into its parent, and
> the msr_param range thing got pulled out into its own patch. Otherwise
> changes are noted in the commit messages.

Thank you very much for reworking the commit messages. The additional 
context do make these changes easier to digest.

On a high level the goal of these patches look good to me but the 
patches themselves do have a few formatting issues and spelling mistakes 
and while bisectability is a stated goal of this work I was surprised to 
find that one patch ("x86/resctrl: Apply offset correction when config 
is staged") cannot compile.

I started to document the formatting issues but found myself duplicating 
a lot of what checkpatch.pl would already tell you. Could you please 
ensure that this series gets a clean bill of health when using 
"checkpatch.pl --strict"? I also recommend the codespell option ... 
there are a few typos in this series that checkpatch.pl was able to pick 
up. It would be more efficient to review this series from such a baseline.

Thank you

Reinette
