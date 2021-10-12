Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C378429E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhJLHED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:04:03 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:55504 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232499AbhJLHEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:04:02 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B046E837F24C;
        Tue, 12 Oct 2021 07:02:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 561E9D1517;
        Tue, 12 Oct 2021 07:01:59 +0000 (UTC)
Message-ID: <55fceaaa0e44585e2b8aeb4ce57d9a5248a879e7.camel@perches.com>
Subject: Re: [PATCH v2] Fix application of sizeof to pointer
From:   Joe Perches <joe@perches.com>
To:     davidcomponentone@gmail.com, jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Date:   Tue, 12 Oct 2021 00:01:58 -0700
In-Reply-To: <17910246df3f6ea3b2ae790af543eefbcefe49a5.1634021064.git.davidcomponentone@gmail.com>
References: <17910246df3f6ea3b2ae790af543eefbcefe49a5.1634021064.git.davidcomponentone@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 561E9D1517
X-Spam-Status: No, score=0.06
X-Stat-Signature: g7hat79sduftxe1ia8igjyyzdua6a11r
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+C2e7nhTwBZeVPPqaTGKy+Yu5QAW/36jY=
X-HE-Tag: 1634022119-875575
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-12 at 14:50 +0800, davidcomponentone@gmail.com wrote:
> From: David Yang <davidcomponentone@gmail.com>
> 
> The coccinelle check report:
> "./arch/um/drivers/virt-pci.c:192:20-26:
> ERROR: application of sizeof to pointer"
> Using the "sizeof(buf->data)" to fix it.

Try compiling this with W=1 or just maybe even just compiling your change.
You've now got an unused declaration of u8 *data;
 
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
[]
> @@ -187,9 +187,8 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
>  		return ~0ULL;
> 
>  	buf = get_cpu_var(um_pci_msg_bufs);
> -	data = buf->data;
> 
> -	memset(data, 0xff, sizeof(data));
> +	memset(buf->data, 0xff, sizeof(buf->data));
>  	switch (size) {
>  	case 1:
> @@ -204,22 +203,22 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
>  		goto out;
>  	}
> 
> -	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
> +	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buf->data, 8))
>  		goto out;
> 
>  	switch (size) {
>  	case 1:
> -		ret = data[0];
> +		ret = buf->data[0];
>  		break;
>  	case 2:
> -		ret = le16_to_cpup((void *)data);
> +		ret = le16_to_cpup((void *)buf->data);
>  		break;
>  	case 4:
> -		ret = le32_to_cpup((void *)data);
> +		ret = le32_to_cpup((void *)buf->data);
>  		break;
>  #ifdef CONFIG_64BIT
>  	case 8:
> -		ret = le64_to_cpup((void *)data);
> +		ret = le64_to_cpup((void *)buf->data);
>  		break;
>  #endif
>  	default:


