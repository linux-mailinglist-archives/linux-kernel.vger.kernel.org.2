Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2EB406431
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbhIJAy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 20:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233802AbhIJAVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:21:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 135BE61101;
        Fri, 10 Sep 2021 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631233233;
        bh=zOuJb7TeTSTm9gK35Cmf38VJxwR/1obK8yK3eMOB0Ik=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VIgcOQFIWOIHomwvC84EBtIk0Io+Fxm5pgyiuOjQftqDf6l6xVPiZWPGqG+WOzzOR
         CqOhcG29HWK/kHSQfX0NnlvGy7enLo3czl+GANSsg9PZdDcxjHNja6Ycq47nAhg0BP
         DjuHiewWmS4vm3u2suVcjzkdqQYX2fnHplDK5V3CHuE/+L+K5E12OGwpf5e5H/L8+s
         aWzQYCPB/shUAK10tYuLEBJs0AFPCMv9hEDMsv4jMu+svm4BM7891OKmqA4GzN1SGL
         xAeeBej7rnSr47VDwvyyCxOvanQKcUYeIj41VPv/FeWQGkejXJdA3kIGlmcw4L6K3x
         Z12RJioc1qrtw==
Message-ID: <a50bfe53931dfebe8e5a65b99d4524841fe2c775.camel@kernel.org>
Subject: Re: [PATCH v4 2/3] x86/sgx: Report SGX memory in /proc/meminfo
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Sep 2021 03:20:30 +0300
In-Reply-To: <20210910001726.811497-2-jarkko@kernel.org>
References: <20210910001726.811497-1-jarkko@kernel.org>
         <20210910001726.811497-2-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-10 at 03:17 +0300, Jarkko Sakkinen wrote:
> @@ -799,7 +805,7 @@ ssize_t arch_node_read_meminfo(struct device *dev,
> =20
>  	len +=3D sysfs_emit_at(buf, len,
>  			     "Node %d SGX_MemTotal:   %8lu kB\n",
> -			     dev->id, node->size);
> +			     dev->id, node->size / 1024);
> =20
>  	return len;
>  }

This should have been in 1/3.

/Jarkko

