Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA223260F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhBZKIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:08:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:60666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhBZKEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:04:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A08BAF3F;
        Fri, 26 Feb 2021 10:04:09 +0000 (UTC)
Subject: Re: [PATCH][RFC] perf annotate: show full line locations with 'k' in
 UI
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <9acb63e0-af38-eeeb-157e-32f6177da557@suse.cz>
 <20210212203408.GH1398414@kernel.org>
 <5b59c46e-4907-7ab9-a68d-dd234e988dc7@suse.cz>
Message-ID: <cf9079f8-8150-710a-79e1-753dc5857815@suse.cz>
Date:   Fri, 26 Feb 2021 11:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <5b59c46e-4907-7ab9-a68d-dd234e988dc7@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I please ping this?

Thanks

On 2/15/21 1:34 PM, Martin Liška wrote:
> On 2/12/21 9:34 PM, Arnaldo Carvalho de Melo wrote:
>> Another idea is to, when requested, reserve one line at the bottom to
>> show what is the source codefile:line  for where the TUI cursor is, i.e.
>> you press down/up and the line under the cursor has its sourcefile:line
>> shown at the second (from bottom to top) line in the screen.
> 
> Hello.
> 
> I decided to use the footer bar and a full location is displayed when 'l'
> hokey is pressed. I think it's quite rare feature, so on demand footer
> line usage should be an appropriate place.
> 
> Thoughts?
> Thanks,
> Martin

