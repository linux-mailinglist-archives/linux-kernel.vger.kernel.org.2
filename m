Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4A312607
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 17:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBGQcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 11:32:18 -0500
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:40882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229506AbhBGQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 11:32:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1333C18029123;
        Sun,  7 Feb 2021 16:31:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:4321:4605:5007:7514:7652:8603:10004:10400:10848:11026:11232:11658:11783:11914:12043:12048:12296:12297:12438:12555:12740:12895:13255:13439:13894:14181:14659:14721:21080:21433:21451:21611:21627:21990:30012:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: owl08_28053bd275f7
X-Filterd-Recvd-Size: 4600
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun,  7 Feb 2021 16:31:32 +0000 (UTC)
Message-ID: <e9ecbee6d8c076fec8d2814b744f991c69a29dec.camel@perches.com>
Subject: Re: [PATCH] staging: gasket: fix indentation and lines ending with
 open parenthesis
From:   Joe Perches <joe@perches.com>
To:     Mahak Gupta <gmahak1@gmail.com>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        rcy@google.com, benchan@chromium.org, toddpoynor@google.com,
        rspringer@google.com
Date:   Sun, 07 Feb 2021 08:31:31 -0800
In-Reply-To: <20210207140928.11029-1-gmahak1@gmail.com>
References: <20210207140928.11029-1-gmahak1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-02-07 at 19:39 +0530, Mahak Gupta wrote:
> This patch fixes warnings of 'checkpatch.pl'. According to
> Linux coding guidelines, code should be aligned properly to
> match with open parenthesis and lines should not end with
> open parenthesis.
> 
> Signed-off-by: Mahak Gupta <gmahak1@gmail.com>
> ---
>  drivers/staging/gasket/gasket_ioctl.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
> index e3047d36d8db..a966231bad42 100644
> --- a/drivers/staging/gasket/gasket_ioctl.c
> +++ b/drivers/staging/gasket/gasket_ioctl.c
> @@ -40,7 +40,7 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
>  
> 
>  /* Read the size of the page table. */
>  static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
> -	struct gasket_page_table_ioctl __user *argp)
> +				       struct gasket_page_table_ioctl __user *argp)
>  {
>  	int ret = 0;
>  	struct gasket_page_table_ioctl ibuf;
> @@ -51,8 +51,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
>  	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
>  		return -EFAULT;
>  
> 
> -	ibuf.size = gasket_page_table_num_entries(
> -		gasket_dev->page_table[ibuf.page_table_index]);
> +	ibuf.size = gasket_page_table_num_entries(gasket_dev->page_table[ibuf.page_table_index]);
>  
> 
>  	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
>  					   ibuf.host_address,
> @@ -66,7 +65,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
>  
> 
>  /* Read the size of the simple page table. */
>  static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
> -	struct gasket_page_table_ioctl __user *argp)
> +					      struct gasket_page_table_ioctl __user *argp)
>  {
>  	int ret = 0;
>  	struct gasket_page_table_ioctl ibuf;
> @@ -92,7 +91,7 @@ static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
>  
> 
>  /* Set the boundary between the simple and extended page tables. */
>  static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
> -	struct gasket_page_table_ioctl __user *argp)
> +				       struct gasket_page_table_ioctl __user *argp)
>  {
>  	int ret;
>  	struct gasket_page_table_ioctl ibuf;
> @@ -107,8 +106,8 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
>  
> 
>  	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
>  		return -EFAULT;
> -	max_page_table_size = gasket_page_table_max_size(
> -		gasket_dev->page_table[ibuf.page_table_index]);
> +	max_page_table_size = gasket_page_table_max_size
> +		(gasket_dev->page_table[ibuf.page_table_index]);
>  
> 
>  	if (ibuf.size > max_page_table_size) {
>  		dev_dbg(gasket_dev->dev,
> @@ -119,8 +118,7 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
>  
> 
>  	mutex_lock(&gasket_dev->mutex);
>  
> 
> -	ret = gasket_page_table_partition(
> -		gasket_dev->page_table[ibuf.page_table_index], ibuf.size);
> +	ret = gasket_page_table_partition(gasket_dev->page_table[ibuf.page_table_index], ibuf.size);
>  	mutex_unlock(&gasket_dev->mutex);
>  
> 
>  	return ret;
> @@ -183,7 +181,7 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
>   * corresponding memory.
>   */
>  static int gasket_config_coherent_allocator(struct gasket_dev *gasket_dev,
> -	struct gasket_coherent_alloc_config_ioctl __user *argp)
> +					    struct gasket_coherent_alloc_config_ioctl __user *argp)
>  {
>  	int ret;
>  	struct gasket_coherent_alloc_config_ioctl ibuf;


