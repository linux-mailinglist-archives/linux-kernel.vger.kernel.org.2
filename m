Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA84409851
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbhIMQGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:06:13 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:47325 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbhIMQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:06:11 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 45242CFB51;
        Mon, 13 Sep 2021 15:58:03 +0000 (UTC)
Received: (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0A0E3C000E;
        Mon, 13 Sep 2021 15:57:37 +0000 (UTC)
Subject: Re: [PATCH 1/2] doc: Fix typo in Documentation/riscv/vm-layout
To:     Leo Yu-Chi Liang <ycliang@andestech.com>, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-riscv@lists.infradead.org
Cc:     ycliang@cs.nctu.edu.tw
References: <20210912155149.130332-1-ycliang@andestech.com>
From:   Alexandre ghiti <alex@ghiti.fr>
Message-ID: <39e34848-65d9-75ce-f1f7-d5ee2c5f31c2@ghiti.fr>
Date:   Mon, 13 Sep 2021 17:57:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210912155149.130332-1-ycliang@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+cc linux-riscv)

On 9/12/21 5:51 PM, Leo Yu-Chi Liang wrote:
> From: Leo Yu-Chi Liang <ycliang@cs.nctu.edu.tw>
>
> Fix a typo of the End Addr field for `direct mapping` section.
>
> The value 0xffffffff7fffffff - 0xffffffe000000000 is 126 GB
> and is not equal to value in the size field.
>
> Update the value to make sense of the memory layout table.
>
> Signed-off-by: Leo Yu-Chi Liang <ycliang@cs.nctu.edu.tw>
> ---
>  Documentation/riscv/vm-layout.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
> index b7f98930d38d..2525cf0d6794 100644
> --- a/Documentation/riscv/vm-layout.rst
> +++ b/Documentation/riscv/vm-layout.rst
> @@ -52,7 +52,7 @@ RISC-V Linux Kernel SV39
>     ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
>     ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
>     ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB | vmalloc/ioremap space
> -   ffffffe000000000 | -128    GB | ffffffff7fffffff |  124 GB | direct mapping of all physical memory
> +   ffffffe000000000 | -128    GB | fffffffeffffffff |  124 GB | direct mapping of all physical memory
>    __________________|____________|__________________|_________|____________________________________________________________
>                                                                |
>                                                                |

You're right, thanks for catching this, you can add:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks again,

Alex

