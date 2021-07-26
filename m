Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BC3D586E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhGZKmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:42:17 -0400
Received: from p-impout006aa.msg.pkvw.co.charter.net ([47.43.26.137]:51093
        "EHLO p-impout006.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233132AbhGZKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:42:15 -0400
Received: from [172.16.10.100] ([68.205.28.126])
        by cmsmtp with ESMTP
        id 7ya4mRJkTB5K57ya4mNdvS; Mon, 26 Jul 2021 11:15:33 +0000
X-Authority-Analysis: v=2.4 cv=ZqIol/3G c=1 sm=1 tr=0 ts=60fe9955
 a=gmNTOe8/cTguWXMaQW2Lwg==:117 a=gmNTOe8/cTguWXMaQW2Lwg==:17
 a=IkcTkHD0fZMA:10 a=8JfSVm6LV8s24FDAgMsA:9 a=QEXdDO2ut3YA:10
Reply-To: dmarkh@cfl.rr.com
Subject: Re: [BUG] FLOPPY DRIVER since 5.10.20
To:     Denis Efremov <efremov@linux.com>, markh@compro.net,
        linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
 <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
From:   Mark Hounschell <dmarkh@cfl.rr.com>
Message-ID: <2f4037b6-7ab3-9592-aaf0-dfcda19d61bc@cfl.rr.com>
Date:   Mon, 26 Jul 2021 07:15:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHXMVgsuY5zc4L+8KWXwihSI6w4QyU+p/y+zUgSOrbivlz9Zt8Fs6L+YAunkrm67xFJ1qjW0u0nit6o+XDk3c69Bo0Jb03dyZhHv7R5V8t85I6TIbaub
 oBd9qZX/Fyu1UnBkboKnA4sgDtbpCmQ6T6MZK2txahr1U18WdqR9Y1blfpy15YKII4bWpJY1ccBwGdeDJXlaLXjGaEZ2/1MFKqsuN1dGFE9bg/JYLPTqPvU5
 DxUs9CZxGoh3r1B29+IIs6Aey6afbJGaCHzKpYtmEfhOP57n9Qj7LUYXMo0D2YStH+P36FjUWIRmIedsaXbirWuZWjX4ITzI+HBMbxFuKkTKHgKINbt5vRD2
 51ot9181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 3:57 AM, Denis Efremov wrote:
> Hi,
> 
> On 7/23/21 9:47 PM, Mark Hounschell wrote:
>>
>> These 2 incremental patches, patch-5.10.19-20 and patch-5.11.2-3 have broken the user land fd = open("/dev/fd0", (O_RDWR | O_NDELAY)); functionality.
> 
> Thank you for the report, I'm looking into this.
> 
>> Since FOREVER before the patch, when using O_NDELAY, one could open the floppy device with no media inserted or even with write protected media without error. "Read-only file system" status is returned only when we actually tried to write to it. We have software still in use today that relies on this functionality.
> 
> If it's a project with open sources could you please give a link?
> 

This is imatterial

