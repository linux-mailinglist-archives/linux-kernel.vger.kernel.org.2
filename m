Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724C3398980
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFBM36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:29:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:45518 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhFBM3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:29:48 -0400
IronPort-SDR: OTsf0rpoxINiDqxWBgZM6Ik1MrmXA2diHsd29kQMhPjj7kOE16vkg7NBXDItWU+eeeWgiWN2bJ
 ZZP7pQdDb6Yw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="201914697"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="201914697"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 05:28:05 -0700
IronPort-SDR: 1024NlcVx5NXR8OoFgdDKvggfwz3zY45Q0jD0FVna4KOh5zG14JQXK41vuPwFAxtuzxbzkJbOD
 VTA6ibVAzKpA==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="479690419"
Received: from okartau-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.75])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 05:28:01 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Igor Torrente <igormtorrente@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: docs: Convert the Speakup guide to rst
In-Reply-To: <85969150-6e00-12b8-b56d-5f161436777d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210531215737.8431-1-igormtorrente@gmail.com> <20210531220754.h4ep2dj65wl6hejf@begin> <b8769ad4-9188-a735-3ac4-4a79b9b06487@gmail.com> <20210601215536.5rhnbwwt66uyqhze@begin> <85969150-6e00-12b8-b56d-5f161436777d@gmail.com>
Date:   Wed, 02 Jun 2021 15:27:58 +0300
Message-ID: <87pmx4pi29.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021, Igor Torrente <igormtorrente@gmail.com> wrote:
> Hi Samuel,
>
> On 6/1/21 6:55 PM, Samuel Thibault wrote:
>> Hello,
>> 
>> Igor Torrente, le mar. 01 juin 2021 12:39:01 -0300, a ecrit:
>>> I was reading all the emails sent in this thread, but I'm not sure how I
>>> should proceed. Do think should I continue to improve the patch with the
>>> Jani Nikula suggestions? Or abandon it? Or keep both versions?
>> 
>> It seems that people are fine with the switch to the .rst format, and
>> it'll indeed allow much better distribution of its content, so please
>> continue improving the patch with the suggestions from Jani, you have an
>> 
>> Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>> 
>> and the review will probably come from Jani, who seems to actually know
>> a bit about the rst syntax :)
>
> OK, I will keep improving it.

Heh, I just made suggestions on things that I thought could be done
better, but please see for yourself how it renders and how it actually
works with Braille displays. That should have priority over anything I
suggest.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
