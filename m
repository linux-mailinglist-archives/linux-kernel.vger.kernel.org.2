Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374CE3F4726
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhHWJMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:12:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35414 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:12:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E23EC21F31;
        Mon, 23 Aug 2021 09:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629709905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0qgBD/eS+CqtlhSXbBBQYs3KkbD5dIBT5UcJ1W98IQ=;
        b=pYrl3UPtB3qWryRRrFe2WPw3bjI2U3qKSGLo605IbX0lyHDquoDvyLqLWU9cteA781xDJx
        hw9YCetVg8ARe89p4wJo8TEZbieKe6IMyEDHoHmMkwQBTpd3AZn3CK/gd1oSGmYo2OR2wj
        Kta4OgLjCcJvIhDGjFZq7W1gJKWBKCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629709905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0qgBD/eS+CqtlhSXbBBQYs3KkbD5dIBT5UcJ1W98IQ=;
        b=PRHKWS6nXCgMqp36wnXDYMAWZhtEB8ZJGFFF2SQaMCPPbGDc9uvzU/4ILK+b0i/EkNxVCW
        UqQjeLYlj6nkSqAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D2A1813A92;
        Mon, 23 Aug 2021 09:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FiDvMlFmI2GPbAAAGKfGzw
        (envelope-from <osalvador@suse.de>); Mon, 23 Aug 2021 09:11:45 +0000
MIME-Version: 1.0
Date:   Mon, 23 Aug 2021 11:11:45 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        mhocko@suse.com, minchan@kernel.org, cgoldswo@codeaurora.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/memory_hotplug: use helper zone_is_zone_device()
 to simplify the code
In-Reply-To: <20210821094246.10149-2-linmiaohe@huawei.com>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-2-linmiaohe@huawei.com>
User-Agent: Roundcube Webmail
Message-ID: <9727e0f1b81dacb3d003dd7bd0f030ba@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-21 11:42, Miaohe Lin wrote:
> Use helper zone_is_zone_device() to simplify the code and remove some
> explicit CONFIG_ZONE_DEVICE codes.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
