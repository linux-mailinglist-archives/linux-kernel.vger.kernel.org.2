Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8DF32663F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBZRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:21:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230045AbhBZRVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:21:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QH2avP089213;
        Fri, 26 Feb 2021 12:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Y3xbNqcIsHsRmCVoVgCcyY3ylJouW6T4C0GUPBOawCs=;
 b=YLDPVU9uvBI5HocSC+EH8X9ltzwelRyj7W2JX1ezbiFTyQvly9loap63x20UVoEZDjLt
 kIUitj4gzNPNwnkJq09IkpahgJKGh3uWl2gJP+nZQNOqx8t7STsla79wkrSA4YVpkn6k
 rt4t/9GBUaktyspxe5gng8UP7gP9zVsctbGwSvuUOnjqDYDP/7AlTKL58FkuatKmTJyL
 c4O2uksC91pggjpAicWpxagUwzQr5Q/p7NC7F4ZWpJwo67gnSHAQEgboiYO/4D4TeDWu
 LOF+LxX2UgxnXL0AssxtqxO7rJ5nXwzhEdoO0eR3stZ7c6VIDtyTQZPzG+pdMCfeeKhc aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y10ssab2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 12:19:50 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QH2gdM089607;
        Fri, 26 Feb 2021 12:19:50 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y10ssaak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 12:19:50 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QH8ZRa012294;
        Fri, 26 Feb 2021 17:19:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 36tt28avy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 17:19:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QHJjNr52953470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 17:19:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E093D11C054;
        Fri, 26 Feb 2021 17:19:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6234711C050;
        Fri, 26 Feb 2021 17:19:45 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.92.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Feb 2021 17:19:45 +0000 (GMT)
Date:   Fri, 26 Feb 2021 18:19:43 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
Message-ID: <20210226171943.GA12088@oc3871087118.ibm.com>
References: <20210114170412.4819-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114170412.4819-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_05:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 06:10:12PM +0106, John Ogness wrote:
> Before commit b6cf8b3f3312 ("printk: add lockless ringbuffer"),
> msg_print_text() would only write up to size-1 bytes into the
> provided buffer. Some callers expect this behavior and append
> a terminator to returned string. In particular:
> 
> arch/powerpc/xmon/xmon.c:dump_log_buf()
> arch/um/kernel/kmsg_dump.c:kmsg_dumper_stdout()
> 
> msg_print_text() has been replaced by record_print_text(), which
> currently fills the full size of the buffer. This causes a
> buffer overflow for the above callers.
> 
> Change record_print_text() so that it will only use size-1 bytes
> for text data. Also, for paranoia sakes, add a terminator after
> the text data.
> 
> And finally, document this behavior so that it is clear that only
> size-1 bytes are used and a terminator is added.

Hi John,

I am seeing KASAN reporting incorrect 1-byte access in exactly
same location Sven has identified before. In case there no
fix for it yet, please see below what happens in case of pretty
large buffer - WARN_ONCE() invocation in my case.

> 
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ffdd0dc7ec6d..73f9eae19f05 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1293,9 +1293,15 @@ static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
>   *   - Add prefix for each line.
>   *   - Add the trailing newline that has been removed in vprintk_store().
>   *   - Drop truncated lines that do not longer fit into the buffer.
> + *   - Add a trailing newline.
> + *   - Add a string terminator.
> + *
> + * Since the produced string is always terminated, the maximum possible
> + * return value is @r->text_buf_size - 1;
>   *
>   * Return: The length of the updated/prepared text, including the added
> - * prefixes and the newline. The dropped line(s) are not counted.
> + * prefixes and the newline. The terminator is not counted. The dropped
> + * line(s) are not counted.
>   */
>  static size_t record_print_text(struct printk_record *r, bool syslog,
>  				bool time)
> @@ -1338,26 +1344,31 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
>  
>  		/*
>  		 * Truncate the text if there is not enough space to add the
> -		 * prefix and a trailing newline.
> +		 * prefix and a trailing newline and a terminator.
>  		 */
> -		if (len + prefix_len + text_len + 1 > buf_size) {
> +		if (len + prefix_len + text_len + 1 + 1 > buf_size) {
>  			/* Drop even the current line if no space. */
> -			if (len + prefix_len + line_len + 1 > buf_size)
> +			if (len + prefix_len + line_len + 1 + 1 > buf_size)
>  				break;
>  
> -			text_len = buf_size - len - prefix_len - 1;
> +			text_len = buf_size - len - prefix_len - 1 - 1;
>  			truncated = true;
>  		}
>  
>  		memmove(text + prefix_len, text, text_len);
>  		memcpy(text, prefix, prefix_len);
>  
> +		/*
> +		 * Increment the prepared length to include the text and
> +		 * prefix that were just moved+copied. Also increment for the
> +		 * newline at the end of this line. If this is the last line,
> +		 * there is no newline, but it will be added immediately below.
> +		 */
>  		len += prefix_len + line_len + 1;

(1) the next iteration of would-be-length stored in len

> -
>  		if (text_len == line_len) {

(2) but the buffer is processed, so we get here

>  			/*
> -			 * Add the trailing newline removed in
> -			 * vprintk_store().
> +			 * This is the last line. Add the trailing newline
> +			 * removed in vprintk_store().
>  			 */
>  			text[prefix_len + line_len] = '\n';
>  			break;

(3) and bail out from the loop

> @@ -1382,6 +1393,14 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
>  		text_len -= line_len + 1;
>  	}
>  
> +	/*
> +	 * If a buffer was provided, it will be terminated. Space for the
> +	 * string terminator is guaranteed to be available. The terminator is
> +	 * not counted in the return value.
> +	 */
> +	if (buf_size > 0)
> +		text[len] = 0;

(4) trying to terminate, but len is beyond the buffer

BUG: KASAN: global-out-of-bounds in record_print_text+0x1d4/0x248
Write of size 1 at addr 00000000bf9e6992 by task swapper/0/1

Reverting the patch shuts the complain.

> +
>  	return len;
>  }
>  
> -- 
> 2.20.1
> 
