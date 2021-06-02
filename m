Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC12398E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhFBPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:20:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhFBPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E817122BD5;
        Wed,  2 Jun 2021 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EExQFawgGd7iNB9vNu/Slav2uxSKgTIBcsMBzXZv3GA=;
        b=WkSOT0SOldZpcTtjEBQH6MupD+n2D9MSEW02p2DCkoaSx8AMDtvclb+QEWL0ot2okh27dT
        I+DrC27OP2RI5wshebG4wLe2ypqk5obXoBoEol3nJk3rAKVE2OTD5KkktPB/Jqb/T0fcj5
        HrXbzcM/0t+8wpJrHLSVKsEuzQNOWFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647106;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EExQFawgGd7iNB9vNu/Slav2uxSKgTIBcsMBzXZv3GA=;
        b=yzQYKBDyRizkQtDd2NGfB/KbTYIyk4CHeQcNd1TjIV886EPeXAZFxIruQUPpYd3VqpLNIN
        rxeW9ohAz/lECHAA==
Received: by imap.suse.de (Postfix, from userid 51)
        id E0B3E11CD5; Wed,  2 Jun 2021 16:04:03 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id CAE9411EE1;
        Wed,  2 Jun 2021 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622643764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EExQFawgGd7iNB9vNu/Slav2uxSKgTIBcsMBzXZv3GA=;
        b=sKT6om9kRHiNpIUHSatr7Fbve41lPc/J6+joteUqMdMyUwawbCXLYogM4ZeqXfu9/uhqu8
        kb6+k4KBhBpuyfa07QA7f/QNlxrK0nHEDHXH03BNU3z55/OB6ZSc3yOj+AwSjyDXN/YLPh
        tCSe8nHx5NNQTX6xvXcgDJkuf9aNIyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622643764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EExQFawgGd7iNB9vNu/Slav2uxSKgTIBcsMBzXZv3GA=;
        b=5ImJD4SUYB2b4tkRVwSm/D7kHCRbSua36lpV7taCsaWdf/53TI5frd/Z3l+Nfn6mC57Bj5
        mLysOBBDxaJnKwCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id tAMPLjOUt2BcZgAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Wed, 02 Jun 2021 14:22:43 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 5284bd4d;
        Wed, 2 Jun 2021 14:22:43 +0000 (UTC)
Date:   Wed, 2 Jun 2021 15:22:42 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: gcov: NULL pointer dereference with gcc 9.3.1
Message-ID: <YLeUMit+CTfZl8pw@suse.de>
References: <YLZYwgs5hyzFZMlw@suse.de>
 <0a013450-75eb-de2c-f90a-3df193800cea@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a013450-75eb-de2c-f90a-3df193800cea@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 02:35:31PM +0200, Peter Oberparleiter wrote:
> On 01.06.2021 17:56, Luis Henriques wrote:
> > Hi!
> > 
> > Maybe this is a known (gcc?) issue, but I'm seeing a NULL pointer splat if
> > I instrument my kernel (or a module, more specifically) using gcc 9.3.1.
> > 
> > It looks like, during initialization in __gcov_init(), gcov_info struct is
> > invalid: the filename seems to be correct but ->function is NULL and
> > ->n_functions contains garbage.
> 
> Thanks for reporting this issue. The symptoms you're seeing look similar
> to those that occur when the struct gcov_info layout emitted by GCC does
> not match the one used by the kernel. In particular a change in the
> GCOV_COUNTER value can cause this behavior.
> 
> I've checked upstream GCC 9.3.1 and it seems to match what is used by
> the kernel for that GCC version. Could you provide the exact version of
> the compiler you are using? Both 'gcc --version' output and the GCC
> package version should help. Also what architecture are you seeing this on?

Here's the output of 'gcc --version':

gcc (SUSE Linux) 9.3.1 20200903 [revision 9790fa53b48f3a48e0f7a7ad65e2bbf3b206a7b0]
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

This is the version shipped with openSUSE Tumbleweed, and I'm using it to
compile an x86_64 kernel.  Regarding the 'package version', I'm assuming
the packages as per the distro package version, right?  Here's the data
from 'zypper info':

Information for package gcc9:
-----------------------------
Repository     : Main Repository (OSS)
Name           : gcc9
Version        : 9.3.1+git1684-3.5
Arch           : x86_64
Vendor         : openSUSE
Installed Size : 94.6 MiB
Installed      : Yes (automatically)
Status         : up-to-date
Source package : gcc9-9.3.1+git1684-3.5.src

Do you have a link with binaries I could test for upstream 9.3.1?  I
checked [1] but there's only 9.3.0.

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/

Cheers,
--
Luís
