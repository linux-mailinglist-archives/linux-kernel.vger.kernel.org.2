Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C419433CB07
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhCPBye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCPByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:54:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD39BC06174A;
        Mon, 15 Mar 2021 18:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JWKAnsu2pp86k4vvBhK5LKLAE6pIvijEW3G7w0H2N6g=; b=vA8yQPegKuxnvz+NVIs4kjWss5
        +pIxVmKBqRmMg7KiaCsdrqYor9BNIhxdSM5yncpltxvdjG1QZPP8FACCVHJlDWVKQJq+3xF7fX4mA
        x2prMkbW+IdTSQbbEQO3pEULEpxFVcz57j+8ZeUD17ldYvTSSTYuIMdKoxum/Wh0xfVZehJYn1NKo
        G40jOTrP8c1FfqbdAf/jGbn++ugKodihQl1IBjynCMR5o4NwJzL4sNxRZeJDAGiscWFB1VtjhhPtN
        79UZ4Gz/RwA9GE3l2wyM8okAnBeE/qWhNOF8wpN4IQXB1ZJyKcGaSn9eG1G6/F9jw4ldphlhg0ctl
        EpKwtB7A==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLyuW-001O15-ML; Tue, 16 Mar 2021 01:54:17 +0000
Subject: Re: [PATCH v4] docs: usbip: Fix major fields and descriptions in
 protocol
To:     "Hongren Zheng (Zenithal)" <i@zenithal.me>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?TcOhcnRvbiBOw6ltZXRo?= <nm127@freemail.hu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Alexandre Demers <alexandre.f.demers@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        usbip-devel@lists.sourceforge.net
References: <YE/Od9WNg3Prw1/h@Sun>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dadd9c38-81e1-0db1-e14f-2bcfb0eebbc4@infradead.org>
Date:   Mon, 15 Mar 2021 18:54:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE/Od9WNg3Prw1/h@Sun>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 2:15 PM, Hongren Zheng (Zenithal) wrote:
> 
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Co-developed-by: Randy Dunlap <rdunlap@infradead.org>

No, I'm not in the Co-developed-by loop here.

And then you can add:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


> Signed-off-by: Hongren Zheng <i@zenithal.me>
> ---
>  Documentation/usb/usbip_protocol.rst | 320 ++++++++++++++-------------
>  1 file changed, 171 insertions(+), 149 deletions(-)
> 
> 
> PATCH v4:
> Suggested by https://lore.kernel.org/linux-doc
> /40351ed6-2907-3966-e69a-a564173b3682@infradead.org/
>   * Add punctuations for readability
>   * Move patch changelog after the marker line
>   * Remove nickname in signed-off-by line
> 
> diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
> index 988c832166cd..54c5677adf4e 100644
> --- a/Documentation/usb/usbip_protocol.rst
> +++ b/Documentation/usb/usbip_protocol.rst



-- 
~Randy

