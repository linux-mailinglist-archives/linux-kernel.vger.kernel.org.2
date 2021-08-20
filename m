Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4BA3F2A75
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbhHTLBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:01:31 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37771 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236783AbhHTLB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:01:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DE69D320093C;
        Fri, 20 Aug 2021 07:00:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 20 Aug 2021 07:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dJKGL4
        F0jfdJf4O3ZKguyRrO1H7CYdNtVqRZZ9k8DUQ=; b=Mz+uuVbdLmz4FDkB9GY3E5
        9uEIMfyMi+8xNJx39oyV5IptyH7FPZ76nIfD2BOiRVmj+2anILJLGY/7ymMZsykx
        M5Z3aSEYf5rzo+nlRAF05N1kz3/8D16e7z83EoYLohezgOdpNdicl+jBKdPxJICs
        oePs8Osf2ys4IFUyWFkyZwA9dE4P1xUO1e4hdbRwVmFCP0H1qrB39VzAi2H+5Y8a
        rYWtbbXBYcZI7ID0hB4JqwERgd3AqdNvwJXJbmElbq8ZpwkbU+9pVHwr36/35eeQ
        tyLpcyzqxuscym1F0HGWL5Q641NzlbADxbprhfsBf25SehhmsAVIBd9+MLT+NM0g
        ==
X-ME-Sender: <xms:YYsfYZkRLLW0qwBEIiXGgPGmuDMdk9rkyqHeUSUNVvXhlZ4-K-HDgQ>
    <xme:YYsfYU0Qleo1EALvJupVfMx6rdJMAVWeNnSPzkycW26J2oatZwxjSXq-NlUiO6RrY
    yJJPkKldJD6bRei6Rg>
X-ME-Received: <xmr:YYsfYfp2eZIF2tn4vnKRR0LAq-dZYKfYmn_kaW7pNXrPmuKHcp_U27f5A6fZKLbtj965tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvkfgjfhfogggtsehttdertd
    ertddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdgu
    vghvqeenucggtffrrghtthgvrhhnpefgfeefudffhffgueehgeffffeggeevieefueethf
    eijefftedugfeuveethedtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:YYsfYZmw9z2jrM7Gsstg0JIXb6VUrfOdpRtC-AGqp0s1N-hzxJjtcA>
    <xmx:YYsfYX1rb6KG6tBNlWZiMxJ-6gPlWoubTeMJgdMEIhok6touJgaRjw>
    <xmx:YYsfYYuuJUJ3J1BU3AtDAac2-05jVglEGQX5tcKLzVG85ziByFHCrQ>
    <xmx:YosfYQ_WEHwnP2xMYlywX4ix5Qdw9R5JPhqeeQGXHTCkBeUmkWqMQA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 07:00:45 -0400 (EDT)
Date:   Fri, 20 Aug 2021 23:00:30 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for custom fan curves
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org
Message-Id: <U8X4YQ.79I8GZJ1LDW02@ljones.dev>
In-Reply-To: <c19dfdde11754c234ca8a45c4af2187699498ee8.camel@hadess.net>
References: <20210820095726.14131-1-luke@ljones.dev>
        <20210820095726.14131-2-luke@ljones.dev>
        <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
        <L0W4YQ.ZVWQDLFJE8NR2@ljones.dev>
        <e7fbcf85f61b5c727a93df07b3bfe1624547067f.camel@hadess.net>
        <c19dfdde11754c234ca8a45c4af2187699498ee8.camel@hadess.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 20 2021 at 12:51:08 +0200, Bastien Nocera 
<hadess@hadess.net> wrote:
> On Fri, 2021-08-20 at 12:43 +0200, Bastien Nocera wrote:
>>  On Fri, 2021-08-20 at 22:33 +1200, Luke Jones wrote:
>>  > > Am I going to get bug reports from Asus users that will complain
>>  > > that
>>  > > power-profiles-daemon doesn't work correctly, where I will have
>>  > > to
>>  > > wearily ask if they're using an Asus Rog laptop?
>>  >
>>  > No. Definitely not. The changes to fan curves per-profile need to
>>  > be
>>  > explicitly enabled and set. So a new user will be unaware that 
>> this
>>  > control exists (until they look for it) and their laptop will
>>  > behave
>>  > exactly as default.
>> 
>>  "The user will need to change the fan curves manually so will
>>  definitely remember to mention it in bug reports" is a very 
>> different
>>  thing to "the user can't change the fan curves to be nonsensical and
>>  mean opposite things".
>> 
>>  I can assure you that I will eventually get bug reports from "power
>>  users" who break their setup and wonder why things don't work
>>  properly,
>>  without ever mentioning the changes they made changes to the fan
>>  curves, or anything else they might have changed.
> 
> A way to taint the settings that power-profiles-daemon could catch
> would be fine by me. I absolutely don't want to have to support
> somebody's tweaks until they undo them.

Definitely understood. Do you have something in mind?

> 


