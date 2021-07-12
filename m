Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC83C629D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhGLScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:32:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:18522 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhGLScm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:32:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="209849450"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="gz'50?scan'50,208,50";a="209849450"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 11:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="gz'50?scan'50,208,50";a="653066593"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2021 11:29:51 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m30gg-000HAe-Nn; Mon, 12 Jul 2021 18:29:50 +0000
Date:   Tue, 13 Jul 2021 02:29:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:auth.v2 3/12] lib/base64.c:27:5: warning: no
 previous prototype for 'base64_encode'
Message-ID: <202107130230.6K1dTxjb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth.v2
head:   9107ea4a3526c6801b38b7a2345b7372278a35ba
commit: 245c033d4a03bc806ab510cf072583c9076eb9d2 [3/12] lib/base64: RFC4648-compliant base64 encoding
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=245c033d4a03bc806ab510cf072583c9076eb9d2
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth.v2
        git checkout 245c033d4a03bc806ab510cf072583c9076eb9d2
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/base64.c:27:5: warning: no previous prototype for 'base64_encode' [-Wmissing-prototypes]
      27 | int base64_encode(const u8 *src, int len, char *dst)
         |     ^~~~~~~~~~~~~
>> lib/base64.c:74:5: warning: no previous prototype for 'base64_decode' [-Wmissing-prototypes]
      74 | int base64_decode(const char *src, int len, u8 *dst)
         |     ^~~~~~~~~~~~~


vim +/base64_encode +27 lib/base64.c

    12	
    13	static const char lookup_table[65] =
    14		"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    15	
    16	/**
    17	 * base64_encode() - base64-encode some bytes
    18	 * @src: the bytes to encode
    19	 * @len: number of bytes to encode
    20	 * @dst: (output) the base64-encoded string.  Not NUL-terminated.
    21	 *
    22	 * Encodes the input string using characters from the set [A-Za-z0-9+,].
    23	 * The encoded string is roughly 4/3 times the size of the input string.
    24	 *
    25	 * Return: length of the encoded string
    26	 */
  > 27	int base64_encode(const u8 *src, int len, char *dst)
    28	{
    29		int i, bits = 0;
    30		u32 ac = 0;
    31		char *cp = dst;
    32	
    33		for (i = 0; i < len; i++) {
    34			ac = (ac << 8) | src[i];
    35			bits += 8;
    36			if (bits < 24)
    37				continue;
    38			do {
    39				bits -= 6;
    40				*cp++ = lookup_table[(ac >> bits) & 0x3f];
    41			} while (bits);
    42			ac = 0;
    43		}
    44		if (bits) {
    45			int more = 0;
    46	
    47			if (bits < 16)
    48				more = 2;
    49			ac = (ac << (2 + more));
    50			bits += (2 + more);
    51			do {
    52				bits -= 6;
    53				*cp++ = lookup_table[(ac >> bits) & 0x3f];
    54			} while (bits);
    55			*cp++ = '=';
    56			if (more)
    57				*cp++ = '=';
    58		}
    59	
    60		return cp - dst;
    61	}
    62	EXPORT_SYMBOL_GPL(base64_encode);
    63	
    64	/**
    65	 * base64_decode() - base64-decode some bytes
    66	 * @src: the base64-encoded string to decode
    67	 * @len: number of bytes to decode
    68	 * @dst: (output) the decoded bytes.
    69	 *
    70	 * Decodes the base64-encoded bytes @src according to RFC 4648.
    71	 *
    72	 * Return: number of decoded bytes
    73	 */
  > 74	int base64_decode(const char *src, int len, u8 *dst)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--WIyZ46R2i8wDzkSu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
E27keYYAAA==

--WIyZ46R2i8wDzkSu--
