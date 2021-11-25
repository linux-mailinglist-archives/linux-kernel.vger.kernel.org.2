Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20045DCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355766AbhKYPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:00:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:22506 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355909AbhKYO6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:58:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235466569"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235466569"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 06:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="498106129"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2021 06:55:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqG9z-0006Vk-DR; Thu, 25 Nov 2021 14:55:39 +0000
Date:   Thu, 25 Nov 2021 22:55:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: lib/zstd/compress/zstd_opt.c:1170 ZSTD_compressBlock_opt_generic()
 warn: inconsistent indenting
Message-ID: <202111252259.qU4k14YN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
date:   2 weeks ago
config: x86_64-randconfig-m001-20211116 (https://download.01.org/0day-ci/archive/20211125/202111252259.qU4k14YN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
lib/zstd/compress/zstd_opt.c:1170 ZSTD_compressBlock_opt_generic() warn: inconsistent indenting
lib/zstd/compress/zstd_compress.c:3602 ZSTD_initCDict_internal() warn: inconsistent indenting
lib/zstd/decompress/huf_decompress.c:397 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
lib/zstd/decompress/huf_decompress.c:397 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
lib/zstd/decompress/huf_decompress.c:850 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
lib/zstd/decompress/huf_decompress.c:850 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
lib/zstd/compress/zstd_lazy.c:983 ZSTD_compressBlock_lazy_generic() warn: if statement not indented
lib/zstd/compress/zstd_lazy.c:1254 ZSTD_compressBlock_lazy_extDict_generic() warn: if statement not indented

Old smatch warnings:
lib/zstd/compress/zstd_lazy.c:1275 ZSTD_compressBlock_lazy_extDict_generic() warn: if statement not indented
lib/zstd/compress/zstd_lazy.c:1285 ZSTD_compressBlock_lazy_extDict_generic() warn: if statement not indented
lib/zstd/compress/zstd_lazy.c:1316 ZSTD_compressBlock_lazy_extDict_generic() warn: if statement not indented
lib/zstd/compress/zstd_lazy.c:1362 ZSTD_compressBlock_lazy_extDict_generic() warn: if statement not indented

vim +1170 lib/zstd/compress/zstd_opt.c

   929	
   930	FORCE_INLINE_TEMPLATE size_t
   931	ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
   932	                               seqStore_t* seqStore,
   933	                               U32 rep[ZSTD_REP_NUM],
   934	                         const void* src, size_t srcSize,
   935	                         const int optLevel,
   936	                         const ZSTD_dictMode_e dictMode)
   937	{
   938	    optState_t* const optStatePtr = &ms->opt;
   939	    const BYTE* const istart = (const BYTE*)src;
   940	    const BYTE* ip = istart;
   941	    const BYTE* anchor = istart;
   942	    const BYTE* const iend = istart + srcSize;
   943	    const BYTE* const ilimit = iend - 8;
   944	    const BYTE* const base = ms->window.base;
   945	    const BYTE* const prefixStart = base + ms->window.dictLimit;
   946	    const ZSTD_compressionParameters* const cParams = &ms->cParams;
   947	
   948	    U32 const sufficient_len = MIN(cParams->targetLength, ZSTD_OPT_NUM -1);
   949	    U32 const minMatch = (cParams->minMatch == 3) ? 3 : 4;
   950	    U32 nextToUpdate3 = ms->nextToUpdate;
   951	
   952	    ZSTD_optimal_t* const opt = optStatePtr->priceTable;
   953	    ZSTD_match_t* const matches = optStatePtr->matchTable;
   954	    ZSTD_optimal_t lastSequence;
   955	    ZSTD_optLdm_t optLdm;
   956	
   957	    optLdm.seqStore = ms->ldmSeqStore ? *ms->ldmSeqStore : kNullRawSeqStore;
   958	    optLdm.endPosInBlock = optLdm.startPosInBlock = optLdm.offset = 0;
   959	    ZSTD_opt_getNextMatchAndUpdateSeqStore(&optLdm, (U32)(ip-istart), (U32)(iend-ip));
   960	
   961	    /* init */
   962	    DEBUGLOG(5, "ZSTD_compressBlock_opt_generic: current=%u, prefix=%u, nextToUpdate=%u",
   963	                (U32)(ip - base), ms->window.dictLimit, ms->nextToUpdate);
   964	    assert(optLevel <= 2);
   965	    ZSTD_rescaleFreqs(optStatePtr, (const BYTE*)src, srcSize, optLevel);
   966	    ip += (ip==prefixStart);
   967	
   968	    /* Match Loop */
   969	    while (ip < ilimit) {
   970	        U32 cur, last_pos = 0;
   971	
   972	        /* find first match */
   973	        {   U32 const litlen = (U32)(ip - anchor);
   974	            U32 const ll0 = !litlen;
   975	            U32 nbMatches = ZSTD_BtGetAllMatches(matches, ms, &nextToUpdate3, ip, iend, dictMode, rep, ll0, minMatch);
   976	            ZSTD_optLdm_processMatchCandidate(&optLdm, matches, &nbMatches,
   977	                                              (U32)(ip-istart), (U32)(iend - ip));
   978	            if (!nbMatches) { ip++; continue; }
   979	
   980	            /* initialize opt[0] */
   981	            { U32 i ; for (i=0; i<ZSTD_REP_NUM; i++) opt[0].rep[i] = rep[i]; }
   982	            opt[0].mlen = 0;  /* means is_a_literal */
   983	            opt[0].litlen = litlen;
   984	            /* We don't need to include the actual price of the literals because
   985	             * it is static for the duration of the forward pass, and is included
   986	             * in every price. We include the literal length to avoid negative
   987	             * prices when we subtract the previous literal length.
   988	             */
   989	            opt[0].price = ZSTD_litLengthPrice(litlen, optStatePtr, optLevel);
   990	
   991	            /* large match -> immediate encoding */
   992	            {   U32 const maxML = matches[nbMatches-1].len;
   993	                U32 const maxOffset = matches[nbMatches-1].off;
   994	                DEBUGLOG(6, "found %u matches of maxLength=%u and maxOffCode=%u at cPos=%u => start new series",
   995	                            nbMatches, maxML, maxOffset, (U32)(ip-prefixStart));
   996	
   997	                if (maxML > sufficient_len) {
   998	                    lastSequence.litlen = litlen;
   999	                    lastSequence.mlen = maxML;
  1000	                    lastSequence.off = maxOffset;
  1001	                    DEBUGLOG(6, "large match (%u>%u), immediate encoding",
  1002	                                maxML, sufficient_len);
  1003	                    cur = 0;
  1004	                    last_pos = ZSTD_totalLen(lastSequence);
  1005	                    goto _shortestPath;
  1006	            }   }
  1007	
  1008	            /* set prices for first matches starting position == 0 */
  1009	            {   U32 const literalsPrice = opt[0].price + ZSTD_litLengthPrice(0, optStatePtr, optLevel);
  1010	                U32 pos;
  1011	                U32 matchNb;
  1012	                for (pos = 1; pos < minMatch; pos++) {
  1013	                    opt[pos].price = ZSTD_MAX_PRICE;   /* mlen, litlen and price will be fixed during forward scanning */
  1014	                }
  1015	                for (matchNb = 0; matchNb < nbMatches; matchNb++) {
  1016	                    U32 const offset = matches[matchNb].off;
  1017	                    U32 const end = matches[matchNb].len;
  1018	                    for ( ; pos <= end ; pos++ ) {
  1019	                        U32 const matchPrice = ZSTD_getMatchPrice(offset, pos, optStatePtr, optLevel);
  1020	                        U32 const sequencePrice = literalsPrice + matchPrice;
  1021	                        DEBUGLOG(7, "rPos:%u => set initial price : %.2f",
  1022	                                    pos, ZSTD_fCost(sequencePrice));
  1023	                        opt[pos].mlen = pos;
  1024	                        opt[pos].off = offset;
  1025	                        opt[pos].litlen = litlen;
  1026	                        opt[pos].price = sequencePrice;
  1027	                }   }
  1028	                last_pos = pos-1;
  1029	            }
  1030	        }
  1031	
  1032	        /* check further positions */
  1033	        for (cur = 1; cur <= last_pos; cur++) {
  1034	            const BYTE* const inr = ip + cur;
  1035	            assert(cur < ZSTD_OPT_NUM);
  1036	            DEBUGLOG(7, "cPos:%zi==rPos:%u", inr-istart, cur)
  1037	
  1038	            /* Fix current position with one literal if cheaper */
  1039	            {   U32 const litlen = (opt[cur-1].mlen == 0) ? opt[cur-1].litlen + 1 : 1;
  1040	                int const price = opt[cur-1].price
  1041	                                + ZSTD_rawLiteralsCost(ip+cur-1, 1, optStatePtr, optLevel)
  1042	                                + ZSTD_litLengthPrice(litlen, optStatePtr, optLevel)
  1043	                                - ZSTD_litLengthPrice(litlen-1, optStatePtr, optLevel);
  1044	                assert(price < 1000000000); /* overflow check */
  1045	                if (price <= opt[cur].price) {
  1046	                    DEBUGLOG(7, "cPos:%zi==rPos:%u : better price (%.2f<=%.2f) using literal (ll==%u) (hist:%u,%u,%u)",
  1047	                                inr-istart, cur, ZSTD_fCost(price), ZSTD_fCost(opt[cur].price), litlen,
  1048	                                opt[cur-1].rep[0], opt[cur-1].rep[1], opt[cur-1].rep[2]);
  1049	                    opt[cur].mlen = 0;
  1050	                    opt[cur].off = 0;
  1051	                    opt[cur].litlen = litlen;
  1052	                    opt[cur].price = price;
  1053	                } else {
  1054	                    DEBUGLOG(7, "cPos:%zi==rPos:%u : literal would cost more (%.2f>%.2f) (hist:%u,%u,%u)",
  1055	                                inr-istart, cur, ZSTD_fCost(price), ZSTD_fCost(opt[cur].price),
  1056	                                opt[cur].rep[0], opt[cur].rep[1], opt[cur].rep[2]);
  1057	                }
  1058	            }
  1059	
  1060	            /* Set the repcodes of the current position. We must do it here
  1061	             * because we rely on the repcodes of the 2nd to last sequence being
  1062	             * correct to set the next chunks repcodes during the backward
  1063	             * traversal.
  1064	             */
  1065	            ZSTD_STATIC_ASSERT(sizeof(opt[cur].rep) == sizeof(repcodes_t));
  1066	            assert(cur >= opt[cur].mlen);
  1067	            if (opt[cur].mlen != 0) {
  1068	                U32 const prev = cur - opt[cur].mlen;
  1069	                repcodes_t newReps = ZSTD_updateRep(opt[prev].rep, opt[cur].off, opt[cur].litlen==0);
  1070	                ZSTD_memcpy(opt[cur].rep, &newReps, sizeof(repcodes_t));
  1071	            } else {
  1072	                ZSTD_memcpy(opt[cur].rep, opt[cur - 1].rep, sizeof(repcodes_t));
  1073	            }
  1074	
  1075	            /* last match must start at a minimum distance of 8 from oend */
  1076	            if (inr > ilimit) continue;
  1077	
  1078	            if (cur == last_pos) break;
  1079	
  1080	            if ( (optLevel==0) /*static_test*/
  1081	              && (opt[cur+1].price <= opt[cur].price + (BITCOST_MULTIPLIER/2)) ) {
  1082	                DEBUGLOG(7, "move to next rPos:%u : price is <=", cur+1);
  1083	                continue;  /* skip unpromising positions; about ~+6% speed, -0.01 ratio */
  1084	            }
  1085	
  1086	            {   U32 const ll0 = (opt[cur].mlen != 0);
  1087	                U32 const litlen = (opt[cur].mlen == 0) ? opt[cur].litlen : 0;
  1088	                U32 const previousPrice = opt[cur].price;
  1089	                U32 const basePrice = previousPrice + ZSTD_litLengthPrice(0, optStatePtr, optLevel);
  1090	                U32 nbMatches = ZSTD_BtGetAllMatches(matches, ms, &nextToUpdate3, inr, iend, dictMode, opt[cur].rep, ll0, minMatch);
  1091	                U32 matchNb;
  1092	
  1093	                ZSTD_optLdm_processMatchCandidate(&optLdm, matches, &nbMatches,
  1094	                                                  (U32)(inr-istart), (U32)(iend-inr));
  1095	
  1096	                if (!nbMatches) {
  1097	                    DEBUGLOG(7, "rPos:%u : no match found", cur);
  1098	                    continue;
  1099	                }
  1100	
  1101	                {   U32 const maxML = matches[nbMatches-1].len;
  1102	                    DEBUGLOG(7, "cPos:%zi==rPos:%u, found %u matches, of maxLength=%u",
  1103	                                inr-istart, cur, nbMatches, maxML);
  1104	
  1105	                    if ( (maxML > sufficient_len)
  1106	                      || (cur + maxML >= ZSTD_OPT_NUM) ) {
  1107	                        lastSequence.mlen = maxML;
  1108	                        lastSequence.off = matches[nbMatches-1].off;
  1109	                        lastSequence.litlen = litlen;
  1110	                        cur -= (opt[cur].mlen==0) ? opt[cur].litlen : 0;  /* last sequence is actually only literals, fix cur to last match - note : may underflow, in which case, it's first sequence, and it's okay */
  1111	                        last_pos = cur + ZSTD_totalLen(lastSequence);
  1112	                        if (cur > ZSTD_OPT_NUM) cur = 0;   /* underflow => first match */
  1113	                        goto _shortestPath;
  1114	                }   }
  1115	
  1116	                /* set prices using matches found at position == cur */
  1117	                for (matchNb = 0; matchNb < nbMatches; matchNb++) {
  1118	                    U32 const offset = matches[matchNb].off;
  1119	                    U32 const lastML = matches[matchNb].len;
  1120	                    U32 const startML = (matchNb>0) ? matches[matchNb-1].len+1 : minMatch;
  1121	                    U32 mlen;
  1122	
  1123	                    DEBUGLOG(7, "testing match %u => offCode=%4u, mlen=%2u, llen=%2u",
  1124	                                matchNb, matches[matchNb].off, lastML, litlen);
  1125	
  1126	                    for (mlen = lastML; mlen >= startML; mlen--) {  /* scan downward */
  1127	                        U32 const pos = cur + mlen;
  1128	                        int const price = basePrice + ZSTD_getMatchPrice(offset, mlen, optStatePtr, optLevel);
  1129	
  1130	                        if ((pos > last_pos) || (price < opt[pos].price)) {
  1131	                            DEBUGLOG(7, "rPos:%u (ml=%2u) => new better price (%.2f<%.2f)",
  1132	                                        pos, mlen, ZSTD_fCost(price), ZSTD_fCost(opt[pos].price));
  1133	                            while (last_pos < pos) { opt[last_pos+1].price = ZSTD_MAX_PRICE; last_pos++; }   /* fill empty positions */
  1134	                            opt[pos].mlen = mlen;
  1135	                            opt[pos].off = offset;
  1136	                            opt[pos].litlen = litlen;
  1137	                            opt[pos].price = price;
  1138	                        } else {
  1139	                            DEBUGLOG(7, "rPos:%u (ml=%2u) => new price is worse (%.2f>=%.2f)",
  1140	                                        pos, mlen, ZSTD_fCost(price), ZSTD_fCost(opt[pos].price));
  1141	                            if (optLevel==0) break;  /* early update abort; gets ~+10% speed for about -0.01 ratio loss */
  1142	                        }
  1143	            }   }   }
  1144	        }  /* for (cur = 1; cur <= last_pos; cur++) */
  1145	
  1146	        lastSequence = opt[last_pos];
  1147	        cur = last_pos > ZSTD_totalLen(lastSequence) ? last_pos - ZSTD_totalLen(lastSequence) : 0;  /* single sequence, and it starts before `ip` */
  1148	        assert(cur < ZSTD_OPT_NUM);  /* control overflow*/
  1149	
  1150	_shortestPath:   /* cur, last_pos, best_mlen, best_off have to be set */
  1151	        assert(opt[0].mlen == 0);
  1152	
  1153	        /* Set the next chunk's repcodes based on the repcodes of the beginning
  1154	         * of the last match, and the last sequence. This avoids us having to
  1155	         * update them while traversing the sequences.
  1156	         */
  1157	        if (lastSequence.mlen != 0) {
  1158	            repcodes_t reps = ZSTD_updateRep(opt[cur].rep, lastSequence.off, lastSequence.litlen==0);
  1159	            ZSTD_memcpy(rep, &reps, sizeof(reps));
  1160	        } else {
  1161	            ZSTD_memcpy(rep, opt[cur].rep, sizeof(repcodes_t));
  1162	        }
  1163	
  1164	        {   U32 const storeEnd = cur + 1;
  1165	            U32 storeStart = storeEnd;
  1166	            U32 seqPos = cur;
  1167	
  1168	            DEBUGLOG(6, "start reverse traversal (last_pos:%u, cur:%u)",
  1169	                        last_pos, cur); (void)last_pos;
> 1170	            assert(storeEnd < ZSTD_OPT_NUM);
  1171	            DEBUGLOG(6, "last sequence copied into pos=%u (llen=%u,mlen=%u,ofc=%u)",
  1172	                        storeEnd, lastSequence.litlen, lastSequence.mlen, lastSequence.off);
  1173	            opt[storeEnd] = lastSequence;
  1174	            while (seqPos > 0) {
  1175	                U32 const backDist = ZSTD_totalLen(opt[seqPos]);
  1176	                storeStart--;
  1177	                DEBUGLOG(6, "sequence from rPos=%u copied into pos=%u (llen=%u,mlen=%u,ofc=%u)",
  1178	                            seqPos, storeStart, opt[seqPos].litlen, opt[seqPos].mlen, opt[seqPos].off);
  1179	                opt[storeStart] = opt[seqPos];
  1180	                seqPos = (seqPos > backDist) ? seqPos - backDist : 0;
  1181	            }
  1182	
  1183	            /* save sequences */
  1184	            DEBUGLOG(6, "sending selected sequences into seqStore")
  1185	            {   U32 storePos;
  1186	                for (storePos=storeStart; storePos <= storeEnd; storePos++) {
  1187	                    U32 const llen = opt[storePos].litlen;
  1188	                    U32 const mlen = opt[storePos].mlen;
  1189	                    U32 const offCode = opt[storePos].off;
  1190	                    U32 const advance = llen + mlen;
  1191	                    DEBUGLOG(6, "considering seq starting at %zi, llen=%u, mlen=%u",
  1192	                                anchor - istart, (unsigned)llen, (unsigned)mlen);
  1193	
  1194	                    if (mlen==0) {  /* only literals => must be last "sequence", actually starting a new stream of sequences */
  1195	                        assert(storePos == storeEnd);   /* must be last sequence */
  1196	                        ip = anchor + llen;     /* last "sequence" is a bunch of literals => don't progress anchor */
  1197	                        continue;   /* will finish */
  1198	                    }
  1199	
  1200	                    assert(anchor + llen <= iend);
  1201	                    ZSTD_updateStats(optStatePtr, llen, anchor, offCode, mlen);
  1202	                    ZSTD_storeSeq(seqStore, llen, anchor, iend, offCode, mlen-MINMATCH);
  1203	                    anchor += advance;
  1204	                    ip = anchor;
  1205	            }   }
  1206	            ZSTD_setBasePrices(optStatePtr, optLevel);
  1207	        }
  1208	    }   /* while (ip < ilimit) */
  1209	
  1210	    /* Return the last literals size */
  1211	    return (size_t)(iend - anchor);
  1212	}
  1213	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
