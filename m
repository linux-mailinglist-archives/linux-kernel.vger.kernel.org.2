Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81F3A88C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhFOStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:49:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:52782 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhFOStj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:49:39 -0400
IronPort-SDR: ZFyBuM88ohB2RGJKlRXfYksR66mFIgQZi6pLL40Rqu0GRHErQeF6lDnovXiEWCy66+5hlFSaYr
 7xassry9wXtw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206086527"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="206086527"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:47:34 -0700
IronPort-SDR: Js4fX3MbHcXLEdJe0tpEIdjPJhsY+edHugjqkLvbBLemKbwxHEub34zOXlB732I35sZY+R8hBf
 7Jos7iPy7ydw==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="554540662"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:47:33 -0700
Subject: Re: [PATCH v2] x86/resctrl: Fix kernel-doc in pseudo_lock.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210608234902.9316-1-fmdefrancesco@gmail.com>
 <4de714ab-47f4-97e3-c35f-184b1218e681@intel.com>
 <2668591.RLH4pUzd2n@linux.local>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <371b8786-6ed5-ae75-efb3-bd1631491a20@intel.com>
Date:   Tue, 15 Jun 2021 11:47:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2668591.RLH4pUzd2n@linux.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio

On 6/14/2021 7:52 AM, Fabio M. De Francesco wrote:

> For what is related to style, if you agree with me, I'd like to have it
> consistent: always capitalize the first word which describes a parameter, and
> always use consistent punctuation among different lines and comments, so I'd
> prepare a patch (or a series) to the files in resctrl. I could called them
> "Make consistent use of capitalization and punctuation". What about it?

While I surely would consider such a submission I wonder if your energy 
may not be better spent on other areas where there are higher priority 
work needed? What is your goal with this work? I understand that you are 
new to Linux kernel development and want to learn but it is not clear to 
me fixing capitalization and punctuation would be a good use of your energy.

> I've also noticed some minor grammar issues (e.g., exist -> exits (in
> pseudo_lock.c, line 752 - pseudo-lock -> pseudo-locked in many other lines).
> What do you think if I make a "Fix English grammar" patch? So what about this
> other too?

This work would make the comments easier to read and a welcome addition. 
Please consider this a lower priority if you come across functional 
issues that could benefit your attention.

Thank you very much

Reinette
