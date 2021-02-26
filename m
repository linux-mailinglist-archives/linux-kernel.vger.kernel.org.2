Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2732620F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBZLkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:40:45 -0500
Received: from ciao.gmane.io ([116.202.254.214]:46476 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhBZLkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:40:43 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1lFbTW-000760-Ht
        for linux-kernel@vger.kernel.org; Fri, 26 Feb 2021 12:40:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?J=c3=b6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: Re: Linux 5.11.2
Date:   Fri, 26 Feb 2021 12:37:18 +0100
Message-ID: <s1amhe$14dl$2@ciao.gmane.io>
References: <1614334214168@kroah.com> <s1ak0f$p2g$1@ciao.gmane.io>
 <YDjVShQyMIVWfZU7@kroah.com> <s1ama6$14dl$1@ciao.gmane.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
In-Reply-To: <s1ama6$14dl$1@ciao.gmane.io>
Content-Language: en-US
Cc:     stable@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jörg-Volker Peetz wrote on 26/02/2021 12.33:
> Greg KH wrote on 26/02/2021 12.02:
>> On Fri, Feb 26, 2021 at 11:54:07AM +0100, Jörg-Volker Peetz wrote:
>>> Hi,
>>>
>>> thanks for the upgrade.
>>> There seems to be a dangling link in the git repository:
>>> `scripts/dtc/include-prefixes/c6x`
>>
>> Is that new?  What commit caused it?
> 
> I think it was a removal, commit 584ce3c9b408a89f, which forgot the link.
> Introduced in 5.11.2.

Should be: introduced after 5.11.2.

Regards,
Jörg.

> 
> Regards,
> Jörg.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> 
> 


