Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19167331DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 04:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCIDo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 22:44:27 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:46620 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCIDoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:44:15 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id ADEAE40018C;
        Tue,  9 Mar 2021 11:44:13 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     wangqing@vivo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v26,1/4] scsi: ufs: Introduce HPB feature
Date:   Tue,  9 Mar 2021 11:44:09 +0800
Message-Id: <1615261449-3940-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614567775-4478-1-git-send-email-wangqing@vivo.com>
References: <1614567775-4478-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk4eHklPHhlMTEpMVkpNSk5JTUpPTkhDQ0NVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NyI6GDo6GT8RCw4IEAIISytK
        EiwaCwtVSlVKTUpOSU1KT05PSkNDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFCSEg3Bg++
X-HM-Tid: 0a781515cdd2d991kuwsadeae40018c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Samsung's iozone test result, HPB is going to boost random 
performance of rom on mobile, we believe it will help our customers on 
several occasions.
