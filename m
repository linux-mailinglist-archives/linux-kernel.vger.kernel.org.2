Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E0E36ABB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhDZFF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:05:59 -0400
Received: from foss.arm.com ([217.140.110.172]:56100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDZFF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:05:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E651131B;
        Sun, 25 Apr 2021 22:05:16 -0700 (PDT)
Received: from [10.163.75.66] (unknown [10.163.75.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70E173F70D;
        Sun, 25 Apr 2021 22:05:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm/mmzone.h: fix existing kernel-doc comments and
 link them to core-api
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210423203811.1247508-1-rppt@kernel.org>
 <20210423203811.1247508-2-rppt@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6eddc206-4653-d3c8-3bcb-e92cf4738504@arm.com>
Date:   Mon, 26 Apr 2021 10:36:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210423203811.1247508-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/21 2:08 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are a couple of kernel-doc comments in include/linux/mmzone.h but
> they have minor formatting issues that would cause kernel-doc warnings.
> 
> Fix the formatting of those comments, add missing Return: descriptions and
> link include/linux/mmzone.h to Documentation/core-api/mm-api.rst
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  Documentation/core-api/mm-api.rst |  2 ++
>  include/linux/mmzone.h            | 43 +++++++++++++++++--------------
>  2 files changed, 26 insertions(+), 19 deletions(-)

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
