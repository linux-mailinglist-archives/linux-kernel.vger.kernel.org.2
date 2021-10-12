Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA49C42ADB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhJLUX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhJLUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:23:55 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A8C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=YbfF12SKzyH1GSb2yu99sBJlROrQsRV5thRBU5YNEg8=; b=K3ZFhESEfeFhfiaSSfMCuG//iT
        G3791YzrKXil8Tbnapp7DtogmVdDUR8Las1INPG/WpgsGD1K/gLIpYX2m4dc2yjwKgtVyDAeGlhBE
        krMkp6La6AY29+R5KxUC2jZMmvqTGR79TG9DqHdVsS1GgYSQcmk3mjMJdxdqWvU89sAIz881wr54m
        6NQUg+6O11A1BWRbUYVNkjn5zoDjNaE5DjzWpdf+Qk/RJXpDVacyN+tBUdX66lIXwdL2Z4tBk/yXq
        SRWtaiYmtOI8o1z5ueCCI53ZAhZX5382unrbVSOCkuadkBNwWZU4O1Tkac7u5JVvj6oZFH2E3NjPb
        z9iYkmIg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maOHY-00Duqf-52; Tue, 12 Oct 2021 20:21:52 +0000
Subject: Re: Unwanted activation of root-processes getting highly activated
To:     Theodore Ts'o <tytso@mit.edu>, secret <andreas-stoewing@web.de>
Cc:     linux-kernel@vger.kernel.org
References: <202110081704.58659.andreas-stoewing@web.de>
 <YWGkC00VQkOX2utl@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c002f762-77bc-da53-8126-09404c72e567@infradead.org>
Date:   Tue, 12 Oct 2021 13:21:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWGkC00VQkOX2utl@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/21 7:15 AM, Theodore Ts'o wrote:
> On Fri, Oct 08, 2021 at 05:04:55PM +0000, secret wrote:
>> Date: 08.10.2021
>>
>> Subject/Betreff: Unwanted activation of root-processes reading and writing out
>> the whole SSD/harddrive ! / Kernel-5.4.134 (pclos, AppArmor / Tor (OpenSuSE)
>> usw. etc.: Freigabe von Informationen, Ausführen von Code mit höheren
>> Privilegien und beliebiger Kommandos in Linux, Erzeugung, Lesen und
>> Überschreiben beliebiger Dateien
>>
>> Hi, Greg, dear Linux experts and friends,
>>
>> this is one of the most dangerous and worst things, Linux can happen!
>> Refering to the actual kernel 5.4.134 ( now up to the actual version 5.4.151
>> and higher, additional remark from 10.08.2021), there still is a problem with
>> unexpectedly activated, highly active root-processes (making the tower-LED
>> causing readwrites onto harddiscs and making the SSD/harddrive blink serious-
>> madly hard for about up to 20 minutes). The whole SSD/harddrive seems to get
>> read out and overwritten!
>>
>> The unwanted, highly by tor (pclos, mga7) resp. firejail activated kernel-
>> root-processes are named
>>
>> kworker/u2:1-kcryptd/253:2 (escpecially this one, CPU: gt; 10%)
>> kworker/0:1H-kblockd
>> dmcrypt_write/2 and
>> jbd2/dm2--8
> 
> Activity by these kernel threads indicate that some userspace program
> running on your system is reading (and in the case of the
> dmcrypt_write and jbd2 kernel threads, writing) data to your hard
> drive.  They are a symptom, not the cause of whatever is causing the
> large amount of activity on your SSD/hard drive.
> 
> It is not something that can be "patched" in the kernel.  It is an
> indication of some program (or possibly malware) running on your
> system is doing a lot of file I/O.
> 
> It is possible that as a result of some web site that you visited, it
> is causing the web browser ("firejail", which sounds like the firefox
> browser running some kind of security sandbox) to do a lot of I/O.  So
> the first thing you might try is to exit the web browser and see that
> causes the I/O to abate.  If it does, and if it starts up again when
> you start the web browser and the web browser is not open on any web
> pages, then you might have some misbehaving browser extension that
> somehow got installed, and you might want to try clearing your browser
> profile and uninstalling all of your browser extensions.
> 
> If exiting the browser does not cause the SSD/HDD activity to stop
> within half a minute or so, then some other userspace program must be
> causing it.  It is possible that this might be some background system
> indexing (for example, rebuilding the locatedb), although normally if
> you've left the system up at night, this sort of activity is done when
> the system is idle typically in the wee hours of the morning.
> 
> But it is also possible that you have some kind of malware installed
> on your system, in which case the only good solution is to reinstall
> it.  In any case, this is not something that kernel developers can
> help you with.  Perhaps if there is a local Linux User's Group that
> you can contact for more assistance, they can help you.  If not,
> you'll need to find someone who can help you with Linux system
> administration.
> 
> Cheers,
> 						- Ted

Hi,
Did you try any of what Ted suggested?
and what happened when you did that?

-- 
~Randy
