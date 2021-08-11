Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A184D3E8851
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhHKC4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:56:55 -0400
Received: from mail-m17656.qiye.163.com ([59.111.176.56]:53122 "EHLO
        mail-m17656.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhHKC4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:56:54 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 22:56:53 EDT
Received: from [172.25.45.51] (unknown [58.251.74.232])
        by mail-m17656.qiye.163.com (Hmail) with ESMTPA id 7AAC3C402E6;
        Wed, 11 Aug 2021 10:48:53 +0800 (CST)
From:   Wu Bo <bo.wu@vivo.com>
Subject: f2fs do DIO write make file corruption
To:     bo.wu@vivo.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Message-ID: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
Date:   Wed, 11 Aug 2021 10:48:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJKQkxWQ0hLHklCTUJIGh
        1DVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6HTo6OT9IAyw3HUpPQxxM
        ERhPC0JVSlVKTUlDTU5LSkhPTklOVTMWGhIXVRkUVQwOOw0SDRRVGBQWRVlXWRILWUFZTkNVSU5K
        VUxPVUlISVlXWQgBWUFKSEtCNwY+
X-HM-Tid: 0a7b331cd85eda02kuws7aac3c402e6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I use the following command to create a file, the file may got corruption:
	f2fs_io write 2 0 512 inc_num dio $path

And when I use bio or to set the chunk size to 1 block, the file is 
normal. The commands as following:
	f2fs_io write 2 0 512 inc_num buffered $path
	f2fs_io write 1 0 512 inc_num dio $path

I find this bug on old kernel version 4.14.117, and not find on version 
4.19.152. So this bug is fixed. Can anyone can tell me which patch fixed 
this bug?
