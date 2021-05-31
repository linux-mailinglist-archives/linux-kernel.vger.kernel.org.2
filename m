Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8E396A09
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 01:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhEaXXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 19:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhEaXXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 19:23:44 -0400
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 May 2021 16:22:03 PDT
Received: from vserver.gregn.net (vserver.gregn.net [IPv6:2607:f2f8:a260::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA00CC061574;
        Mon, 31 May 2021 16:22:03 -0700 (PDT)
Received: from vbox.gregn.net (unknown [IPv6:2607:fb90:e55f:fbf1:e1a2:b65d:244b:7834])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vserver.gregn.net (Postfix) with ESMTPSA id 85F0E16E1;
        Mon, 31 May 2021 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gregn.net; s=default;
        t=1622502951; bh=02IP9E67DB88E0k1PeLCEByh3o8tQo6MKoOx3LkNMcg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=cm3uWM2FuioWjam2y5RQny5bBcRX0PJvsuKIZ8SvLvmVHtcXDHrl8sHIIdi2sXu6t
         jJ11WsnCQr4pN/w0aBdo2e8iQT+3efR7bPAz290PflkB53BCxcgn2xjuohM8kFWg3E
         RhM3ivjx57KO/ohvo+eLV4C8Nf9UCYjAdtl7RiGW5rEE0RGVrOAuLedY7TcOqog85K
         tLw90tESFV6YnaPHFm3ycjwyqGCix+sKC3z3M2vlNqLwkEs/rgTz2HlRYXoRBH60Pq
         76ibIGvSTMK4uVR00R2r5xyM9s+sOi15ZLt1ZBCfgiE4rm5CyYRg3UNjQmmHsRN9ov
         JPCPl+JhBOHgw==
Received: from greg by vbox.gregn.net with local (Exim 4.84_2)
        (envelope-from <greg@gregn.net>)
        id 1lnr7r-0002MQ-J8; Mon, 31 May 2021 16:15:15 -0700
Date:   Mon, 31 May 2021 16:15:15 -0700
From:   Gregory Nowak <greg@gregn.net>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: docs: Convert the Speakup guide to rst
Message-ID: <20210531231515.GB8130@gregn.net>
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531220754.h4ep2dj65wl6hejf@begin>
X-PGP-Key: http://www.gregn.net/pubkey.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: clamav-milter 0.102.4 at vserver
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 12:07:54AM +0200, Samuel Thibault wrote:
> Mmm, I'm unsure how the result is readable with the speakup screen
> reader itself. I have attached the result, could people on the speakup
> mailing list check how well it goes? If it significantly degrades
> readability, we'll have to reject the move to rst formatting, since in
> the end it's people who use the speakup screen reader who need to be
> able to read this document.

It sounds OK to me with punctuation level set to 1, and using software
synthesis through espeakup. The formatting could be a problem if
someone is using a higher punctuation level, or a braille
display. Could a txtdocs option be implemented as a documentation
target for kernel builds, which would produce plain text files? That I
think would provide the best of both worlds where the guide could be
maintained as RST, but could be output in plain text like the format
the guide exists in now.

Another concern is that if the speakup guide is maintained in RST,
that could dissuade others from keeping it updated who don't already
know RST.

Greg


-- 
web site: http://www.gregn.net
gpg public key: http://www.gregn.net/pubkey.asc
skype: gregn1
(authorization required, add me to your contacts list first)
If we haven't been in touch before, e-mail me before adding me to your contacts.

--
Free domains: http://www.eu.org/ or mail dns-manager@EU.org
