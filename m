Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0F42CF53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhJMX5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:57:10 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:45546 "EHLO
        esgaroth.petrovitsch.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJMX5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:57:09 -0400
X-Greylist: delayed 2325 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 19:57:08 EDT
Received: from [172.16.0.171] (84-115-220-36.cable.dynamic.surfer.at [84.115.220.36])
        (authenticated bits=0)
        by esgaroth.petrovitsch.at (8.16.1/8.16.1) with ESMTPSA id 19DNGIrV2308444
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Thu, 14 Oct 2021 01:16:20 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 19DNGIrV2308444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
        s=default; t=1634166981;
        bh=O76F8TO9YlVhKwZnc2N/VsKTLxp6Ep8igwW0jsOiAGo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cC1/dxzL7WLo7UFJJ1lxyteO7mDqP8nQk1428uY/2Q9q51YHWDjOZEZrHnf8kwoeL
         J44jcetNp6tD2bxObWSB8I/7oBSLxUDmmUSTAfeJeM9+HZcNcLKM/b4mOVGZLaW+ew
         r1N5ZFHWp6bR1YGSERxk5I9joNoSfY5ieg/yYKNA=
X-Info-sendmail: I was here
Message-ID: <9bae5c76-db1e-b9e3-cdfa-ab22f9d8b58c@petrovitsch.priv.at>
Date:   Thu, 14 Oct 2021 01:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Use of '%#02x' is almost always wrong
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Joe Perches'" <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>
References: <b04a10ea9682c51764053c1be73d4b3be59d1e7f.camel@perches.com>
 <f41e216ed5074c55ad024e68a7dfaa3c@AcuMS.aculab.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <f41e216ed5074c55ad024e68a7dfaa3c@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-sonic-Metrics: esgaroth.petrovitsch.priv.at 1254; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 NICE_REPLY_A Looks like a legit reply (A)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        esgaroth.petrovitsch.priv.at
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On 12/10/2021 23:10, David Laight wrote:
[...]
>> So presumably all the uses of %#02x in the kernel are not outputting
>> what is actually expected.  Perhaps all of these should use %#04x.
> 
> Doesn't help. The definition of "%#x" is completely broken.

Seconded ...

> Basically 0 doesn't get the "0x" prefix, so "%#04x" outputs

... just because of that.
And if one get's in touch with tools where format strings are
the % -stuff is not consistently used ...

> "0000" if the value is zero.
> So the correct replacement is (probably) "0x%02x".

At least it's consistent that way.

And in the big techie picture, I don't see what the '#' modifer
buys and why it makes sense to use it.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
      There is NO CLOUD, just other people's computers. - FSFE
                      LUGA : http://www.luga.at
