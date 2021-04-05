Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C30353C34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 09:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhDEHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 03:40:51 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53749 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231523AbhDEHku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 03:40:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 158035C00BA;
        Mon,  5 Apr 2021 03:40:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Apr 2021 03:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=zGNkm2/gmXzlSftAc6jQBCucSXb
        u4EyYlyjWv6TrtL0=; b=I0T+JVoZKJED70OY1KSuK0E+2TVTguWOC+irdvL+1KE
        K2OL0vDovMcY123tSLyiPB9ulRHeuEsxvxvwS3iCaNpILBF3WPddhHqEgzCGt7Y8
        c9xfFskjYAiwirx9prePknzoi34PN414CpivKOvaYxVy2y97cv0LZUYZgthR/TfO
        g1aILdrxwFGQhuMZxPODE2UlGQ4Rrmu6XDbAspgZSzlj6KYu5xZgVd4ZjWiskRWX
        2b45sDtl7R8ekfEDZMhxKwumPiTu1wJNl/O8GNXiNDauvwfkXBhgKSyWq3vChVMJ
        jwckRI1Rx8bEXtqLbUzKb/fPkN5Vgh5Apw2HQXPXRUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zGNkm2
        /gmXzlSftAc6jQBCucSXbu4EyYlyjWv6TrtL0=; b=hM1LyMsUUirhjj9S2hF3SE
        ARcljRpmREDLNxA74LYbcBMmuLagqiOSUCbI09TYkp92DaT98eURimpVG44TQWMO
        r5zM6E83XLss1dS+z0w34SGTFfMnE1u7F7L+hvqYLjTBjmvlT372NK9wo+pyxaWv
        ELILdUBWa/DxqQJeJT3i4hsIr0/48ZZPWNgowmoImx4LTszijs4VbH3fA65+wy7V
        xXwKPvhrOv+fhVWg6k6i3XnQS2bx5YylXOrggXxF9MQtwQkoqtjlNyAT7B/10ZgS
        KAApSakEYmaJGGRK175noPTXLtGIqLaKeNbtVNPsxu+A7BgToE7OMsQR78Md4pFQ
        ==
X-ME-Sender: <xms:-75qYK03Dwusf79nPf92RafkT2RU6Bm45EPC_bHQJXUOaO1igpJY4Q>
    <xme:-75qYNE-8gLJRwTfuM6VDah1BLQyi8E-q9B2vnrngVELEQybtDZ5hLUvkwcKeE7oL
    3zI93TnlOMu7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeuleeltdehkeeltefhleduuddvhfffuedvffduveeghe
    ekgeeiffevheegfeetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:-75qYC7doAOwXhDeyg5eNT8d9er6Cu3ACeQY6fsclbIvvT_m0x41oA>
    <xmx:-75qYL3sgCHcNftCqRmeYoYXzCDlCFClyooRYxQpsaMKYEr8R_Qfjw>
    <xmx:-75qYNFeFnmgTrtESr3AuYJFpKDv4b5vB8oGyAokb7gT4eTkMOPBcw>
    <xmx:_L5qYAMyDxO_406YDBTzvgDV8gqjNfgj3PmVgp1GrfWP81JGQAtafA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7D6351080057;
        Mon,  5 Apr 2021 03:40:43 -0400 (EDT)
Date:   Mon, 5 Apr 2021 09:40:41 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "kbuild: Add resolve_btfids clean to root clean target"
 has been added to the 5.11-stable tree
Message-ID: <YGq++WjSWmL0ErZX@kroah.com>
References: <20210403185651.42BB36124B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403185651.42BB36124B@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 02:56:50PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     kbuild: Add resolve_btfids clean to root clean target
> 
> to the 5.11-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      kbuild-add-resolve_btfids-clean-to-root-clean-target.patch
> and it can be found in the queue-5.11 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This breaks 'make clean' on 5.10.y and 5.11.y, so I'm going to have to
drop this.

thanks,

greg k-h
