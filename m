Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F33328D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCIOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:44:03 -0500
Received: from first.geanix.com ([116.203.34.67]:48624 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhCIOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:43:49 -0500
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id CBF051042194;
        Tue,  9 Mar 2021 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1615301026; bh=5RZieV+SAbNsuo0XB+MLPX7hw2a5w3czDqDtyR4HbV4=;
        h=To:Cc:Reply-To:From:Subject:Date;
        b=i/D/3Fn5XqDBXOeJCePzlYmpWfiIjNGjPrrDcG/fm7++wGPGKEBCEWBAGeihPfoow
         MmoVgV2bFPiWq1lvGusQxk1zrsMwNSHWJTmXGJjQKsvWAUqWpZwsn602F7ASNF+uFk
         3HAwr+coePfWI1n621pZgXmCfx5tJdK0MEARnkH0ow4Ya7BgwS4ghxlX1TS2pSgQTk
         8VxICyOrIYW+08j5Os3PJxnGRnAXjHZ1zXSBaSkOwsVU2ap+ynO30ai9o0Xe4Du/ha
         dXwfKy4YGIjfEx1U5iNh9WgyvnjquFKYvWsI/6Wa3q7ZygvCCHfFEIl+nJjo9E22Er
         /f/AD/U9BoPVQ==
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: 20210308213717.e319cbf5675a5e427efbdded@linux-foundation.org
From:   Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] Squashfs: fix xattr id and id lookup sanity checks
Message-ID: <9fae170a-db85-d871-4604-8fc313ff5131@geanix.com>
Date:   Tue, 9 Mar 2021 15:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-0.6 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

This patch depends on my patch ([PATCH] squashfs: fix inode lookup sanity checks)
which add's the SQUASHFS_BLOCK_OFFSET :)

/Sean

