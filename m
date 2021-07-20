Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B941A3CF4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhGTGVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:21:36 -0400
Received: from foss.arm.com ([217.140.110.172]:51834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242681AbhGTGVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:21:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 435561FB;
        Tue, 20 Jul 2021 00:01:50 -0700 (PDT)
Received: from [10.163.66.175] (unknown [10.163.66.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFE5F3F73D;
        Tue, 20 Jul 2021 00:01:47 -0700 (PDT)
Subject: Re: [PATCH 01/12] mm/debug_vm_pgtable: Introduce struct
 vm_pgtable_debug
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com,
        chuhu@redhat.com
References: <20210706061748.161258-1-gshan@redhat.com>
 <20210706061748.161258-2-gshan@redhat.com>
 <a74549ac-6794-25a0-7238-2591745e6810@arm.com>
 <65dbdc03-dd34-570c-6beb-7497855b5c8e@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1e39cb49-21d8-7114-4ffa-237c6fa19de9@arm.com>
Date:   Tue, 20 Jul 2021 12:32:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <65dbdc03-dd34-570c-6beb-7497855b5c8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 11:09 AM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 7/14/21 4:24 PM, Anshuman Khandual wrote:
>> On 7/6/21 11:47 AM, Gavin Shan wrote:
> 
> Thanks for your review. I will take all your suggestion if it's applicable.
> Otherwise, I will explain as below. All changes will be included in v2,
> which will be posted pretty soon.

You revised the series couple of times before I could even respond
here :) Anyways, I will jump to V3 directly and continue reviewing
from there.

- Anshuman
