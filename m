Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6A337945
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhCKQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:26:22 -0500
Received: from mx1.riseup.net ([198.252.153.129]:40104 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234236AbhCKQ0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:26:12 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DxDpQ0nrNzDxwh;
        Thu, 11 Mar 2021 08:26:05 -0800 (PST)
X-Riseup-User-ID: 7AAFB2099E8636E625DAB6398A9EBC6B512DE49EC7AFAC50626660AB2E40B1CE
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4DxDpN0fgvz5vY7;
        Thu, 11 Mar 2021 08:26:03 -0800 (PST)
Subject: Re: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210309203919.15920-1-jnewsome@torproject.org>
 <m1blbqmy2u.fsf@fess.ebiederm.org>
 <4d9006b4-b65a-6ce0-b367-971f29de1f21@torproject.org>
 <20210311151542.GB15552@redhat.com>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <dd410f8c-4ab6-107e-8ae9-4b35be0d8885@torproject.org>
Date:   Thu, 11 Mar 2021 10:26:02 -0600
MIME-Version: 1.0
In-Reply-To: <20210311151542.GB15552@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/21 09:15, Oleg Nesterov wrote:
> On 03/10, Jim Newsome wrote:
>> On 3/10/21 16:40, Eric W. Biederman wrote:
>>
>>>> +static int do_wait_pid(struct wait_opts *wo)
>>>> +{
>>>> +	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
>>>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> This is subtle change in behavior.
>>>
>>> Today on the task->children list we only place thread group leaders.
>> Shouldn't we allow waiting on clone children if __WALL or __WCLONE is set?
> Don't confuse clone child with child's sub-thread.

Oops! Thanks; got it. v4 coming shortly


